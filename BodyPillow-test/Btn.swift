//
//  Btn.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/15.
//

import SwiftUI

struct Btn: View {
    var label: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(label)
                .foregroundStyle(.white)
        }
        .frame(width: 100,height: 40)
        .border(Color.white)
    }
}

#Preview {
    Btn(label: "Sample", action: {})
}
