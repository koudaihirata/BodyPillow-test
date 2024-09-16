//
//  ResultView.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/16.
//

import SwiftUI

struct SleepSheetView: View {
    var body: some View {
        VStack(spacing: 20) {
            // ハンドル
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 40, height: 6)
                .padding(.top, 8)
            
            // コンテンツ
            Text("睡眠を開始")
                .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 18))
                .bold()
                .foregroundColor(.white)
            
            Button(action: {
                // 睡眠開始のアクションをここに追加
                print("睡眠を開始するボタンが押されました")
            }) {
                Text("睡眠を開始")
                    .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("BtnColor"))
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("DarkMainColor"))
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct ResultView: View {
    @State private var userSleepTime: Double = 0
    @State private var sleepData: [CGFloat] = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    
    // シートの位置を管理する状態変数
    @State private var sheetPosition: SheetPosition = .closed
    @State private var currentDragOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 背景
                LinearGradient(
                    gradient: Gradient(colors: [Color("MainColor"), Color("SubColor")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    // ヘッダー
                    HStack(spacing: 72) {
                        Image("Alarm")
                        
                        Text("9月/16日")
                            .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 24))
                            .bold()
                            .foregroundStyle(.white)
                        
                        Image("setting")
                    }
                    
                    // フィルターボタン
                    HStack(spacing: 20) {
                        ZStack {
                           Text("1日")
                                .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 12))
                                .bold()
                                .foregroundStyle(.white)
                        }
                        .frame(width: 70, height: 30)
                        .background(Color("BtnColor"))
                        .cornerRadius(20)
                        
                        ZStack {
                           Text("1ヶ月")
                                .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 12))
                                .bold()
                                .foregroundStyle(.black)
                        }
                        .frame(width: 70, height: 30)
                        .background(Color("Btn2Color"))
                        .cornerRadius(20)
                        
                        ZStack {
                           Text("1年")
                                .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 12))
                                .bold()
                                .foregroundStyle(.black)
                        }
                        .frame(width: 70, height: 30)
                        .background(Color("Btn2Color"))
                        .cornerRadius(20)
                    }
                    
                    // カスタムグラフコンポーネント
                    circleCom(sleepTime: userSleepTime)
                    
                    // 情報表示エリア
                    VStack{
                        Text("初めまして")
                            .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 10))
                            .bold()
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .leading], 16)
                        
                        Spacer()
                    }
                    .frame(width: 350, height: 84)
                    .background(Color("DarkMainColor"))
                    .cornerRadius(20)
                    
                    // 睡眠グラフ
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
                            .offset(x: 28, y: -8)
                            
                            SleepGraphCom(sleepData: sleepData)
                                .offset(x: 12, y: 30)
                        }
                    }
                    .frame(width: 350, height: 200)
                    .background(Color("DarkMainColor"))
                    .cornerRadius(20)
                }
                .zIndex(0) // メインコンテンツの優先度を下げる
                
                // シートが開いている場合、背景を暗くするオーバーレイ
                if sheetPosition != .closed {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                sheetPosition = .closed
                            }
                        }
                        .zIndex(1) // オーバーレイの優先度
                }
                
                // カスタムボトムシート
                VStack {
                    Spacer()
                    VStack(spacing: 20) {
                        // シートのハンドル
                        Capsule()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 40, height: 6)
                            .padding(.top, 8)
                        
                        // シートのコンテンツ
                        Text("睡眠を開始")
                            .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 18))
                            .bold()
                            .foregroundColor(.white)
                        
                        Button(action: {
                            // 睡眠開始のアクション
                            print("睡眠を開始するボタンが押されました")
                        }) {
                            Text("睡眠を開始")
                                .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 16))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("BtnColor"))
                                .cornerRadius(10)
                        }
                        
                    }
                    .padding()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                    .background(Color("DarkMainColor"))
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .offset(y: sheetPosition.offset(for: geometry) + currentDragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // ユーザーがドラッグ中のオフセットを更新
                                let newOffset = value.translation.height
                                // シートが閉じている場合、ドラッグアップのみ許可
                                if sheetPosition == .closed && newOffset < 0 {
                                    currentDragOffset = newOffset
                                }
                                // シートが半開きまたは完全に開いている場合、上下両方向のドラッグを許可
                                else if sheetPosition == .half || sheetPosition == .full {
                                    currentDragOffset = newOffset
                                }
                            }
                            .onEnded { value in
                                // ドラッグ終了時にシートの新しい位置を決定
                                let dragHeight = value.translation.height
                                let threshold: CGFloat = 100 // スナップの閾値
                                
                                withAnimation(.easeInOut) {
                                    if dragHeight > threshold {
                                        // ドラッグが下方向で閾値を超えた場合
                                        switch sheetPosition {
                                        case .full:
                                            sheetPosition = .half
                                        case .half:
                                            sheetPosition = .closed
                                        case .closed:
                                            // 閉じている状態でさらに下にドラッグした場合は何もしない
                                            break
                                        }
                                    }
                                    else if dragHeight < -threshold {
                                        // ドラッグが上方向で閾値を超えた場合
                                        switch sheetPosition {
                                        case .half:
                                            sheetPosition = .full
                                        case .closed:
                                            sheetPosition = .half
                                        case .full:
                                            // 完全に開いている状態でさらに上にドラッグした場合は何もしない
                                            break
                                        }
                                    }
                                    else {
                                        // 閾値に達していない場合は現在の位置に戻す
                                        // ドラッグの方向に応じてスナップする位置を決定
                                        if sheetPosition == .closed {
                                            sheetPosition = .half
                                        }
                                        else if sheetPosition == .half {
                                            if dragHeight < 0 {
                                                sheetPosition = .full
                                            }
                                            else {
                                                sheetPosition = .closed
                                            }
                                        }
                                        else if sheetPosition == .full {
                                            if dragHeight > 0 {
                                                sheetPosition = .half
                                            }
                                            else {
                                                sheetPosition = .full
                                            }
                                        }
                                    }
                                    // ドラッグオフセットをリセット
                                    currentDragOffset = 0
                                }
                            }
                    )
                    .animation(.easeInOut, value: sheetPosition)
                    .zIndex(2) // シートの優先度
                }
            }
        }
    }
    
    // シートの位置を管理するenum
    enum SheetPosition {
        case closed
        case half
        case full
        
        func offset(for geometry: GeometryProxy) -> CGFloat {
            switch self {
            case .closed:
                return geometry.size.height
            case .half:
                return geometry.size.height * 0.5
            case .full:
                return geometry.size.height * 0.2
            }
        }
    }
    
    struct ResultView_Previews: PreviewProvider {
        static var previews: some View {
            ResultView()
        }
    }
}
