//
//  ResultView.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/16.
//

import SwiftUI

struct ResultView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("MainColor"), Color("SubColor")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                HStack(spacing: 72) {
                    Image("Alarm")
                    
                    Text("9月/15日")
                        .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 24))
                        .bold()
                        .foregroundStyle(.white)
                    
                    Image("setting")
                }
                
                HStack(spacing: 20) {
                    ZStack {
                       Text("1日")
                            .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 12))
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .frame(width: 70,height: 30)
                    .background(Color("BtnColor"))
                    .cornerRadius(20)
                    
                    ZStack {
                       Text("1ヶ月")
                            .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 12))
                            .bold()
                            .foregroundStyle(.black)
                    }
                    .frame(width: 70,height: 30)
                    .background(Color("Btn2Color"))
                    .cornerRadius(20)
                    
                    ZStack {
                       Text("1年")
                            .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 12))
                            .bold()
                            .foregroundStyle(.black)
                    }
                    .frame(width: 70,height: 30)
                    .background(Color("Btn2Color"))
                    .cornerRadius(20)
                }
                
                
                
                
                VStack{
                    Text("昨日は寝苦しかったみたいですね")
                        .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 10))
                        .bold()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .leading], 16)
                    
                    Spacer()
                }
                .frame(width: 350,height: 84)
                .background(Color("DarkMainColor"))
                .cornerRadius(20)
                
                ZStack{
                   
                }
                .frame(width: 350,height: 200)
                .background(Color("DarkMainColor"))
                .cornerRadius(20)
            }
        }
    }
}

#Preview {
    ResultView()
}
