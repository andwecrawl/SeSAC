//
//  LoginView.swift
//  PracticeSwiftUI
//
//  Created by yeoni on 2023/11/14.
//

import SwiftUI

struct LoginElement {
    @State var value: String
    @State var placeholder: String
}

struct LoginView: View {
    
    var email = LoginElement(value: "", placeholder: "이메일 또는 전화번호")
    var password = LoginElement(value: "", placeholder: "비밀번호")
    var nickname = LoginElement(value: "", placeholder: "닉네임")
    var location = LoginElement(value: "", placeholder: "위치")
    var invitationCode = LoginElement(value: "", placeholder: "추천 코드 입력")
    
    @State var isOn = true
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Image("heeflix")
                    .padding(4)
                
                NetflixTextField(text: email.$value, placeholder: email.$placeholder)
                NetflixTextField(text: password.$value, placeholder: password.$placeholder)
                NetflixTextField(text: nickname.$value, placeholder: nickname.$placeholder)
                NetflixTextField(text: location.$value, placeholder: location.$placeholder)
                NetflixTextField(text: invitationCode.$value, placeholder: invitationCode.$placeholder)
                
                Button(action: {
                    print("welcome!")
                }, label: {
                    Text("회원가입")
                        .padding(.horizontal, 150)
                        .padding(.vertical, 15)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                        .foregroundColor(.black)
                })
                .padding(6)
                
                Toggle("추가 정보 입력", isOn: $isOn)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}

struct NetflixTextField: View {
    
    @Binding var text: String
    @Binding var placeholder: String
    
    var body: some View {
        TextField("", text: $text, prompt: Text("\(placeholder)").foregroundColor(.white))
            .multilineTextAlignment(.center)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(.gray)
                    .frame(height: 46)
            )
            .foregroundStyle(.black)
            .padding()
    }
}
