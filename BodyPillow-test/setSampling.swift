//
//  setSampling.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/15.
//

import SwiftUI
import AVFoundation
import Accelerate

// ViewModelクラスの定義
class SamplingViewModel: ObservableObject {
    // Recording management variables
    @Published var countdown: Int = 3
    @Published var currentRecordingIndex: Int = 0
    @Published var isRecording: Bool = false
    @Published var showStartButton: Bool = true
    @Published var fftMagnitudes: [Float] = Array(repeating: 0, count: 512) // Increased size for better resolution
    
    // Recording phrases
    let recordingPhrases: [String] = ["おやすみ", "おはよう", "あいうえお"]
    
    // Recorded file URLs
    @Published var recordedFiles: [URL] = []
    
    // AVAudioEngine components
    private let audioEngine = AVAudioEngine()
    private var audioFile: AVAudioFile?
    
    // Start the countdown
    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                timer.invalidate()
                self.startRecording()
            }
        }
    }
    
    // Start recording using AVAudioEngine
    func startRecording() {
        isRecording = true
        fftMagnitudes = Array(repeating: 0, count: 512) // Reset FFT magnitudes
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try audioSession.setActive(true)
            
            // Prepare audio file for recording
            let fileName = "recording_\(currentRecordingIndex).m4a"
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            let format = audioEngine.inputNode.outputFormat(forBus: 0)
            audioFile = try AVAudioFile(forWriting: url, settings: format.settings)
            
            // Install tap on input node
            let inputNode = audioEngine.inputNode
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, when in
                // Write buffer to file
                do {
                    try self.audioFile?.write(from: buffer)
                } catch {
                    print("Error writing buffer: \(error.localizedDescription)")
                }
                
                // Perform FFT
                self.processAudioBuffer(buffer: buffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            
            // Stop recording after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.stopRecording()
            }
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }
    
    // Stop recording and handle the next steps
    func stopRecording() {
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        isRecording = false
        
        if let url = audioFile?.url {
            recordedFiles.append(url)
        }
        
        if currentRecordingIndex < recordingPhrases.count - 1 {
            currentRecordingIndex += 1
            countdown = 3
            startCountdown()
        } else {
            // All recordings completed
            // You can add any completion logic here
        }
    }
    
    // Process audio buffer for FFT
    func processAudioBuffer(buffer: AVAudioPCMBuffer) {
        guard let channelData = buffer.floatChannelData?[0] else { return }
        let channelDataValue = Array(UnsafeBufferPointer(start: channelData, count: Int(buffer.frameLength)))
        
        // Perform FFT
        let magnitudes = performFFT(on: channelDataValue)
        
        // Update FFT magnitudes on the main thread
        DispatchQueue.main.async {
            self.fftMagnitudes = magnitudes
        }
    }
    
    // Perform FFT on audio samples
    func performFFT(on audioSamples: [Float]) -> [Float] {
        let log2n = UInt(round(log2(Double(audioSamples.count))))
        guard let fftSetup = vDSP_create_fftsetup(log2n, Int32(kFFTRadix2)) else {
            return []
        }
        
        let length = Int(audioSamples.count)
        let halfLength = length / 2
        
        var realp = [Float](repeating: 0, count: halfLength)
        var imagp = [Float](repeating: 0, count: halfLength)
        var splitComplex = DSPSplitComplex(realp: &realp, imagp: &imagp)
        
        audioSamples.withUnsafeBufferPointer { pointer in
            pointer.baseAddress!.withMemoryRebound(to: DSPComplex.self, capacity: length) {
                vDSP_ctoz($0, 2, &splitComplex, 1, vDSP_Length(halfLength))
            }
        }
        
        vDSP_fft_zrip(fftSetup, &splitComplex, 1, log2n, FFTDirection(FFT_FORWARD))
        
        var magnitudes = [Float](repeating: 0.0, count: halfLength)
        vDSP_zvmags(&splitComplex, 1, &magnitudes, 1, vDSP_Length(halfLength))
        
        // Normalize and convert to dB
        var normalizedMagnitudes = [Float](repeating: 0.0, count: halfLength)
        
        // 1. 各要素の平方根を計算
        var sqrtMagnitudes = [Float](repeating: 0.0, count: halfLength)
        vvsqrtf(&sqrtMagnitudes, magnitudes, [Int32(halfLength)])
        
        // 2. スケーリング
        var scale: Float = 2.0 / Float(length)
        vDSP_vsmul(sqrtMagnitudes, 1, &scale, &normalizedMagnitudes, 1, vDSP_Length(halfLength))
        
        // 3. dB変換
        var dbScale: Float = 1.0
        vDSP_vdbcon(normalizedMagnitudes, 1, &dbScale, &normalizedMagnitudes, 1, vDSP_Length(halfLength), 0)
        
        vDSP_destroy_fftsetup(fftSetup)
        
        return normalizedMagnitudes
    }
    
    // Stop the audio engine
    func stopAudioEngine() {
        if audioEngine.isRunning {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    }
    
    // Get the documents directory URL
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct setSampling: View {
    @StateObject var viewModel = SamplingViewModel()
    @State private var isShowingResultView = false // 遷移用のフラグ

    var body: some View {
        VStack(spacing: 60) {
            VStack(spacing: 60) {
                HStack(spacing: 20) {
                    ZStack {
                        Color("GrayColor").ignoresSafeArea()
                    }
                    .frame(width: 10, height: 10)
                    .cornerRadius(10)
                    
                    ZStack {
                        Color("GrayColor").ignoresSafeArea()
                    }
                    .frame(width: 10, height: 10)
                    .cornerRadius(10)
                    
                    ZStack {
                        Color("AccentColor").ignoresSafeArea()
                    }
                    .frame(width: 10, height: 10)
                    .cornerRadius(10)
                }
                
                Text("サンプリングの設定")
                    .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 24))
                    .bold()
                    .foregroundStyle(.white)
            }
            .offset(y: 66)
            
            Spacer()
            
            VStack {
                VStack(spacing: 26) {
                    Text("サンプル音声を録音します")
                        .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 16))
                        .bold()
                        .foregroundStyle(.white)
                    
                    Text("スマホに向かって\n下の言葉を\n発声してください。")
                        .foregroundStyle(Color("ExplanationColor"))
                        .multilineTextAlignment(.center)
                }
                .offset(y: -40)
                
                // Countdown or Visualizer
                if !viewModel.showStartButton {
                    if viewModel.countdown > 0 {
                        Text("\(viewModel.countdown)")
                            .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 32))
                            .bold()
                            .foregroundStyle(.white)
                    } else {
                        // Show the FFT-based visualizer
                        AudioVisualizer(fftMagnitudes: viewModel.fftMagnitudes)
                            .frame(height: 60)
                            .offset(x: 50)
                    }
                }
                
                // Current recording phrase or completion message
                if viewModel.recordedFiles.count == 3 {
                    Text("録音が完了しました")
                        .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 24))
                        .bold()
                        .foregroundColor(.red)
                        .offset(y: 40)
                } else {
                    Text(viewModel.recordingPhrases[viewModel.currentRecordingIndex])
                        .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 24))
                        .bold()
                        .foregroundStyle(.white)
                        .offset(y: 40)
                }
            }
            .offset(y: -32)
            
            Spacer()
            
            VStack {
                if viewModel.recordedFiles.count == 3 {
                    // 録音が完了したら ResultView に画面遷移するボタンを表示
                    Btn(label: "完了", action: {
                        isShowingResultView = true // フルスクリーンのResultViewへ遷移
                    })
                    .fullScreenCover(isPresented: $isShowingResultView) {
                        ResultView()
                    }
                } else if viewModel.showStartButton {
                    Button(action: {
                        viewModel.showStartButton = false
                        viewModel.startCountdown()
                    }) {
                        Text("スタート")
                            .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 16))
                            .bold()
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else {
                    Text("\(viewModel.recordedFiles.count)/3 完了")
                        .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 16))
                        .bold()
                        .foregroundStyle(.white)
                }
            }
            .offset(y: -100)
        }
        .onDisappear {
            viewModel.stopAudioEngine()
        }
    }
}

// FFT-based Audio Visualizer
struct AudioVisualizer: View {
    var fftMagnitudes: [Float]
    
    var body: some View {
        GeometryReader { geometry in
            let barCount = 50 // Number of bars to display
            let step = fftMagnitudes.count / barCount
            let barWidth = geometry.size.width / CGFloat(barCount * 2)
            
            HStack(alignment: .center, spacing: barWidth / 2) {
                ForEach(0..<barCount, id: \.self) { index in
                    let magnitude = fftMagnitudes[index * step]
                    // Scale magnitude for visualization
                    let scaledMagnitude = min(max((magnitude + 100) / 100, 0), 1) // Normalize between 0 and 1
                    let barHeight = CGFloat(scaledMagnitude) * geometry.size.height // FloatをCGFloatにキャスト
                    
                    RoundedRectangle(cornerRadius: barWidth / 2)
                        .fill(Color.green)
                        .frame(width: barWidth, height: barHeight)
                }
            }
        }
    }
}

struct setSampling_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("MainColor").ignoresSafeArea().opacity(0.6)
            setSampling()
        }
    }
}
