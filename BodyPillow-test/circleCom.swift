//
//  circleCom.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/16.
//

import SwiftUI

struct circleCom: View {
    var sleepTime: Double
    private let maxSleepTime: Double = 12

    var body: some View {
        ZStack {
            // 背景の円（全体のゲージ）
            Circle()
                .stroke(Color("DarkMainColor").opacity(0.2), lineWidth: 20)

            // 現在の進捗を示す円（進行部分）
            Circle()
                .trim(from: 0.0, to: CGFloat(sleepTime / maxSleepTime))
                .stroke(Color("BtnColor"), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(90))  // ゲージの開始位置を12時に
                .animation(.easeInOut, value: sleepTime)

            // ゲージの先端に白い丸を表示
            Circle()
                .fill(Color.white)
                .frame(width: 15, height: 15)  // 白い丸のサイズ
                .offset(x: 100)  // ゲージの半径分だけ右にオフセット
                .rotationEffect(.degrees(360 * (sleepTime / maxSleepTime) + 90))  // ゲージの進行に合わせて回転
                .animation(.easeInOut, value: sleepTime)

            // テキスト表示
            VStack {
                Text("今日の睡眠時間")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                Text("\(Int(sleepTime)) h")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    circleCom(sleepTime: 9)
}
