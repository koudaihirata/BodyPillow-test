//
//  ContentView.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("MainColor"), Color("SubColor")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            ZStack {
                Text("ここにロゴ")
                    .frame(width: 100, height: 100)
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    ContentView()
}

