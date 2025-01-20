//
//  SignupView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/18/25.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        VStack (spacing: 15) {
            
            Spacer()
            
            Image("PacePalLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 100)
                
            VStack (alignment: .leading) {
                Text("Email Address")
                    .opacity(0.4)
                TextField("", text: $email)
            }
                .customTextFieldShape(color: .gray.opacity(0.11))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            
            VStack (alignment: .leading) {
                Text("Full Name")
                    .opacity(0.4)
                TextField("", text: $fullName)
            }
            .customTextFieldShape(color: .gray.opacity(0.11))

            
            VStack (alignment: .leading) {
                Text("Password")
                    .opacity(0.4)
                SecureField("", text: $password)
            }
            .customTextFieldShape(color: .gray.opacity(0.11))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)

            
            VStack (alignment: .leading) {
                Text("Confirm Password")
                    .opacity(0.4)
                SecureField("", text: $confirmPassword)
            }
            .customTextFieldShape(color: .gray.opacity(0.11))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .padding(.horizontal, 30)
            .padding(.bottom, 25)
            
            // TODO: Finish SignUp Button
            Button {
                Task {
                    try await authViewModel.createUser(withEmail: email, password: password, confirmPassword: confirmPassword, fullName: fullName)
                }
            } label: {
                Text("SIGN UP")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)  // Button fills the cutom shape
                    .bold()
                    .foregroundStyle(.white)
            }
                .customTextFieldShape(color: Color(hex: 0x53A57D))
            
            Spacer()
            Spacer()
    }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: 0xFBF7F4))
        .ignoresSafeArea()
        .preferredColorScheme(.light)
    }
}

#Preview {
    SignupView()
        .environment(AuthViewModel())
}
