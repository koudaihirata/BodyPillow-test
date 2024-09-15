//
//  setPairing.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/15.
//

import SwiftUI

struct setPairing: View {
    @Binding var currentPage: Int
    
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
                        Color("AccentColor").ignoresSafeArea()
                    }
                    .frame(width: 10,height: 10)
                    .cornerRadius(10)
                    
                    ZStack {
                        Color("GrayColor").ignoresSafeArea()
                    }
                    .frame(width: 10,height: 10)
                    .cornerRadius(10)
                }
                
                Text("ペアリングを設定")
                    .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 24))
                    .bold()
                    .foregroundStyle(.white)
            }
            .offset(y: 66)
            
            Spacer()
            
            Btn(label: "次へ", action: {
                currentPage = 3
            })
                .offset(y:-100)
        }
    }
}

