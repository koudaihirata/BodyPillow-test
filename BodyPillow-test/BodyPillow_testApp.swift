//
//  BodyPillow_testApp.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/15.
//

import SwiftUI

@main
struct BodyPillow_testApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView: View {
    @State private var showContentView = true
    @State private var showSettingView = false
    
    var body: some View {
        ZStack {
            if showContentView {
                ContentView()
                    .transition(.opacity)
            } else {
                settingView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut(duration: 1.5)) {
                    showContentView = false
                }

                // ContentViewがフェードアウトした後にsettingViewをフェードイン
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        showSettingView = true
                    }
                }
            }
        }
    }
}
