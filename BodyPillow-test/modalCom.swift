//
//  modalCom.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/16.
//

import SwiftUI

struct modalCom: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("注意")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("BtnColor"))
                .cornerRadius(10, corners: [.topLeft, .topRight])

            Spacer()
            
            Text("抱き枕にWi-Fiが接続されてません。\n再接続してください。")
                .multilineTextAlignment(.center)
                .font(.system(size: 14))
                .padding(.horizontal, 16)
            
            Spacer()
            
            Button(action: {
            }) {
                Text("再接続")
                    .font(.system(size: 12))
                    .frame(width: 100, height: 30)
                    .background(Color("BtnColor"))
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                    .offset(y: -18)
            }
        }
        .frame(maxWidth: 300,maxHeight: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
        .padding()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    modalCom()
}
