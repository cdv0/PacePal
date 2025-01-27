//
//  EditProfileView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/26/25.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment (\.dismiss) var dismiss
    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var isSecured = true
    
    var body: some View {
        if let user = authViewModel.currentUser {
            VStack {
                // TODO: Implement profile picture
                Text(user.initials)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 72, height: 72)
                    .background(Color(.systemGray3))
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color(hex: 0x53A57D),lineWidth: 2)
                    )
                
                // MARK: Name field
                VStack (alignment: .leading) {
                    Text("Name")
                        .opacity(0.4)
                    TextField("", text: $fullName)
                }
                .customTextFieldShape(color: .gray.opacity(0.11))
                
                // MARK: Email field
                VStack (alignment: .leading) {
                    Text("Email Address")
                        .opacity(0.4)
                    TextField("", text: $email)
                }
                .customTextFieldShape(color: .gray.opacity(0.11))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                
                // TODO: Reset password
                
                Button {
                    Task {
                        try await authViewModel.updateUser(fullName: fullName, email: email)
                    }
                    
                    dismiss()
                } label: {
                    Text("SAVE")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Button fills the cutom shape
                        .bold()
                        .foregroundStyle(.white)
                }
                    .customTextFieldShape(color: Color(hex: 0x53A57D))
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit Profile")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    EditProfileView()
        .environmentObject(AuthViewModel())
}
