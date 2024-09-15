//
//  ContentView.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/15.
//

import SwiftUI

struct ContentView: View {
    @State private var rotationAngle: Double = 0 // 回転角度を管理

    var body: some View {
        VStack(spacing: 24) {
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100)
                .scaledToFit()
                .shadow(color: .gray, radius: 10, x: 1, y: 1)
            
            // 無限に回転するローディングUI
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: rotationAngle)) // 回転を適用
                .onAppear {
                    withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                        rotationAngle = 360 // 1秒で1回転
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
