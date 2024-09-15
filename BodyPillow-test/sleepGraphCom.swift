import SwiftUI

struct SleepGraphCom: View {
    let sleepData: [CGFloat]
    // let sleepData: [CGFloat] = [1,0.8, 0.2, 0.7, 0.3, 0.4, 0.9, 0.6, 0.1, 0.5, 1, 1, 1]
    let hours: [String] = ["0","01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    
    var body: some View {
        GeometryReader { parentGeometry in
            VStack {
                ZStack {
                    // グラフの背景
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("MainColor"))
                    
                    // グラフの縦線とラベルを同じループで描画
                    ForEach(0..<hours.count, id: \.self) { i in
                        let xPosition = CGFloat(i) * (parentGeometry.size.width * 0.8 / CGFloat(hours.count - 1))
                        
                        // 縦の線
                        Path { path in
                            path.move(to: CGPoint(x: xPosition, y: 0))
                            path.addLine(to: CGPoint(x: xPosition, y: parentGeometry.size.height * 0.6)) // グラフ部分の高さに調整
                        }
                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                        
                        // ラベル
                        Text(hours[i])
                            .font(.system(size: 8))
                            .foregroundColor(.white)
                            .position(x: xPosition, y: parentGeometry.size.height * 0.6 + 10) // グラフ下に配置
                    }
                    
                    // グラフの塗りつぶし
                    Path { path in
                        for (index, value) in sleepData.enumerated() {
                            let xPosition = CGFloat(index) * (parentGeometry.size.width * 0.8 / CGFloat(sleepData.count - 1))
                            let yPosition = (1 - value) * (parentGeometry.size.height * 0.6)
                            if index == 0 {
                                path.move(to: CGPoint(x: xPosition, y: yPosition))
                            } else {
                                path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                            }
                        }
                        // グラフの下を閉じて塗りつぶす
                        path.addLine(to: CGPoint(x: parentGeometry.size.width * 0.8, y: parentGeometry.size.height * 0.6))
                        path.addLine(to: CGPoint(x: 0, y: parentGeometry.size.height * 0.6))
                        path.closeSubpath()
                    }
                    .fill(Color("GraphColor").opacity(0.5))
                    
                    // グラフのライン
                    Path { path in
                        for (index, value) in sleepData.enumerated() {
                            let xPosition = CGFloat(index) * (parentGeometry.size.width * 0.8 / CGFloat(sleepData.count - 1))
                            let yPosition = (1 - value) * (parentGeometry.size.height * 0.6)
                            if index == 0 {
                                path.move(to: CGPoint(x: xPosition, y: yPosition))
                            } else {
                                path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                            }
                        }
                    }
                    .stroke(Color("GraphColor"), lineWidth: 2)
                }
                .frame(width: parentGeometry.size.width * 0.8, height: parentGeometry.size.height * 0.6)
                
                Spacer()
            }
            .frame(width: parentGeometry.size.width, height: parentGeometry.size.height)
        }
        .frame(height: 200) // 必要に応じて高さを調整
    }
}

struct SleepGraphCom_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("DarkMainColor")
                .edgesIgnoringSafeArea(.all)
            SleepGraphCom(sleepData: [1,0.8, 0.2, 0.7, 0.3, 0.4, 0.9, 0.6, 0.1, 0.5, 1, 1, 1])
        }
    }
}
