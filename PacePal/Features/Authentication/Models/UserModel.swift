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
        let nameParts = fullName.split(separator: " ")
        let firstInitial = nameParts.first?.prefix(1).uppercased() ?? ""
        let lastInitial = nameParts.dropFirst().first?.prefix(1).uppercased() ?? ""
        return firstInitial + lastInitial
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Jack Smith", email: "jacksmith123@gmail.com")
}
