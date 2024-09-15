//
//  settingView.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/15.
//

import SwiftUI

struct settingView: View {
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("MainColor"), Color("SubColor")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if currentPage == 0 {
                setCom1(currentPage: $currentPage)
            } else if currentPage == 1 {
                setCom2(currentPage: $currentPage)
            } else if currentPage == 2 {
                setPairing(currentPage: $currentPage)
            } else if currentPage == 3 {
                setSampling()
            }
        }
    }
}

#Preview {
    settingView()
}
