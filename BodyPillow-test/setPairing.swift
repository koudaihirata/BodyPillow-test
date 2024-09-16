import SwiftUI

struct setPairing: View {
    @Binding var currentPage: Int
    
    // ペアリングの状態を定義
    enum PairingState {
        case initial      // 初期状態：抱き枕に近づけてください
        case pairing      // ペアリング中
        case completed    // 接続完了
    }
    
    // 現在のペアリング状態を管理するための@State変数
    @State private var pairingState: PairingState = .initial
    
    var body: some View {
        VStack(spacing: 60) {
            // 進行状況インジケータ
            VStack(spacing: 60) {
                HStack(spacing: 20) {
                    PairingIndicator(isActive: false)
                    PairingIndicator(isActive: true)
                    PairingIndicator(isActive: false)
                }
                
                Text("ペアリングを設定")
                    .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 24))
                    .bold()
                    .foregroundColor(.white)
            }
            .offset(y: 66)
            
            Spacer()
            
            // ペアリングプロセスに応じたUI表示
            VStack(spacing: 20) {
                switch pairingState {
                case .initial:
                    Text("抱き枕に近づけてください")
                        .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 18))
                        .foregroundColor(.white)
                case .pairing:
                    ProgressView("接続中...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .foregroundColor(.white)
                        .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 18))
                case .completed:
                    Text("接続完了")
                        .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 18))
                        .foregroundColor(.white)
                    
                    Btn(label: "次へ", action: {
                        currentPage = 3
                    })
                }
            }
            .onAppear {
                startPairingProcess()
            }
            
            Spacer()
        }
    }
    
    // ペアリングプロセスを管理する関数
    private func startPairingProcess() {
        // 初期状態のまま3秒待機
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                pairingState = .pairing
            }
            
            // ペアリング中の状態を3秒間表示
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    pairingState = .completed
                }
            }
        }
    }
}

// ペアリングインジケータ用のカスタムビュー
struct PairingIndicator: View {
    var isActive: Bool
    
    var body: some View {
        ZStack {
            if isActive {
                Color("AccentColor")
            } else {
                Color("GrayColor")
            }
        }
        .frame(width: 10, height: 10)
        .cornerRadius(5)
    }
}
