//
//  setName.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/15.
//

import SwiftUI

struct setName: View {
    @State var BPName = ""
    
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
                }
                
                Text("名前を設定")
                    .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 24))
                    .bold()
                    .foregroundStyle(.white)
            }
            .offset(y: 66)
            
            Spacer()
            
            VStack {
                Text("抱き枕に名前をつけましょう。")
                    .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 16))
                    .bold()
                    .foregroundStyle(.white)
                    .offset(y: -72)
                
                ZStack {
                    if BPName.isEmpty {
                        Text("日月ミムロ")
                            .foregroundColor(Color("GrayColor"))
                    }
                    TextField("", text: $BPName)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 250,height: 38)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white),
                    alignment: .bottom
                )
            }
            
            Spacer()
            
            Btn(label: "次へ", action: {})
                .offset(y:-100)
        }
    }
}

#Preview {
    setName()
}
