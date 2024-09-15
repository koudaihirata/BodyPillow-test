//
//  ResultView.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/16.
//

import SwiftUI

struct ResultView: View {
    @State private var userSleepTime: Double = 9
    @State private var sleepData: [CGFloat] = [1,0.8, 0.2, 0.7, 0.3, 0.4, 0.9, 0.6, 0.1, 0.5, 1, 1, 1]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("MainColor"), Color("SubColor")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 32) {
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
                
                circleCom(sleepTime: userSleepTime)
                
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
                    HStack(spacing: 0) {
                        VStack(spacing: 38){
                            Text("目覚め")
                                .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 10))
                                .bold()
                                .foregroundStyle(.white)
                            Text("浅い")
                                .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 10))
                                .bold()
                                .foregroundStyle(.white)
                            Text("深い")
                                .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 10))
                                .bold()
                                .foregroundStyle(.white)
                        }
                        .offset(x: 28,y: -8)
                        
                        SleepGraphCom(sleepData: sleepData)
                            .offset(x: 12,y: 30)
                    }
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
