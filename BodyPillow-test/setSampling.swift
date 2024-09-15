//
//  setSampling.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/15.
//

import SwiftUI

struct setSampling: View {
    @State private var countdown = 3
    @State private var timerActive = true
    
    var body: some View {
        VStack(spacing: 60) {
            VStack(spacing: 60) {
                HStack(spacing: 20) {
                    ZStack {
                        Color("GrayColor").ignoresSafeArea()
                    }
                    .frame(width: 10,height: 10)
                    .cornerRadius(10)
                    
                    ZStack {
                        Color("GrayColor").ignoresSafeArea()
                    }
                    .frame(width: 10,height: 10)
                    .cornerRadius(10)
                    
                    ZStack {
                        Color("AccentColor").ignoresSafeArea()
                    }
                    .frame(width: 10,height: 10)
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
                
                Text("3")
                    .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 32))
                    .bold()
                    .foregroundStyle(.white)
                
                Text("おやすみ")
                    .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 24))
                    .bold()
                    .foregroundStyle(.white)
                    .offset(y: 40)
                
            }
            
            Spacer()
            
            Text("0/3完了")
                .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 16))
                .bold()
                .foregroundStyle(.white)
                .offset(y: -100)
        }
    }
    
    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    ZStack {
        Color("MainColor").ignoresSafeArea().opacity(0.6)
        
        setSampling()
    }
}
