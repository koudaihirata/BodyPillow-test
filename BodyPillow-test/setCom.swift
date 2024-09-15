//
//  setCom.swift
//  BodyPillow-test
//
//  Created by Kodai Hirata on 2024/09/15.
//

import SwiftUI

struct PasswordField: View {
    let titleKey: LocalizedStringKey
    @Binding var text: String

    @State var isShowSecure = false
    @FocusState var isTextFieldFocused: Bool
    @FocusState var isSecureFieldFocused: Bool

    init(_ titleKey: LocalizedStringKey, text: Binding<String>) {
        self.titleKey = titleKey
        _text = text
    }

    var body: some View {
        HStack {
            ZStack {
                TextField(titleKey, text: $text)
                    .focused($isTextFieldFocused)
                    .keyboardType(.asciiCapable)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.none)
                    .opacity(isShowSecure ? 1 : 0)

                SecureField(titleKey, text: $text)
                    .focused($isSecureFieldFocused)
                    .opacity(isShowSecure ? 0 : 1)
            }
            .offset(x: -16)

            Button {
                if isShowSecure {
                    isShowSecure = false
                    isSecureFieldFocused = true
                } else {
                    isShowSecure = true
                    isTextFieldFocused = true
                }

            } label: {
                Image(systemName: isShowSecure ? "eye" : "eye.slash")
            }
            .buttonStyle(.plain)
        }
        .padding()
    }
}

struct setCom1: View {
    @State var inputName = ""
    @State var password = ""
    @State var repassword = ""
    @State var err = ""
    
    @Binding var currentPage: Int
    
    var body: some View {
        VStack {
            VStack {
                VStack(spacing: 60) {
                    HStack(spacing: 20) {
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
                    Text("アカウント登録")
                        .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 24))
                        .bold()
                        .foregroundStyle(.white)
                }
                
                VStack(spacing: 50) {
                    ZStack {
                        if inputName.isEmpty {
                            Text("メールアドレス")
                                .foregroundColor(Color("GrayColor"))
                                .offset(x: -70)
                        }
                        TextField("", text: $inputName)
                            .foregroundColor(.white)
                    }
                    .frame(width: 250,height: 38)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.white),
                        alignment: .bottom
                    )
                
                    
                    ZStack {
                        if password.isEmpty {
                            Text("パスワード")
                                .foregroundColor(Color("GrayColor"))
                                .offset(x: -85)
                        }
                        PasswordField("PasswordField", text: $password)
                            .foregroundColor(.white)
                    }
                    .frame(width: 250,height: 38)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.white),
                        alignment: .bottom
                    )
                    
                    ZStack {
                        if repassword.isEmpty {
                            Text("パスワード確認")
                                .foregroundColor(Color("GrayColor"))
                                .offset(x: -70)
                        }
                        PasswordField("PasswordField", text: $repassword)
                            .foregroundColor(.white)
                    }
                    .frame(width: 250,height: 38)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.white),
                        alignment: .bottom
                    )
                }
                .offset(y:90)
            }
            .offset(y:66)
            
            Spacer()
            
            VStack {
                Text(err)
                    .foregroundColor(Color.red)
                
                Btn(label: "登録", action: {
                    if(repassword == password) {
                        print(inputName)
                        print(password)
                        
                        currentPage = 1
                    } else {
                        err = "パスワードが一致しません"
                    }
                })
            }
            .offset(y:-100)
        }
    }
}
struct setCom2: View {
    @Binding var currentPage: Int
    
    var body: some View {
        VStack(spacing: 60) {
            VStack(spacing: 60) {
                HStack(spacing: 20) {
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
                
                Text("アカウント登録")
                    .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 24))
                    .bold()
                    .foregroundStyle(.white)
            }
            .offset(y: 66)
            
            Spacer()
            
            Text("登録が完了しました。")
                .font(.custom("A P-OTF Bunkyu Gothic Pr6", size: 16))
                .bold()
                .foregroundStyle(.white)
            
            Spacer()
            
            Btn(label: "次へ", action: {
                currentPage = 2
            })
                .offset(y:-100)
        }
    }
}
