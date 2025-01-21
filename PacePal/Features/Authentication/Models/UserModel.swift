//
//  UserModel.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/18/25.
//

import Foundation

struct User: Identifiable, Codable {
    // TODO: Clean up User properties (username, password, confirmpassword)
    let id: String
    var fullName: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Jack Smith", email: "jacksmith123@gmail.com")
}
