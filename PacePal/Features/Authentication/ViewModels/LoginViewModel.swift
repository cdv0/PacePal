//
//  LoginViewModel.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/17/25.
//

import Foundation
import Combine

@Observable
class LoginViewModel {
    var user = User()
    var isSecured: Bool = true
        
    func loginPressed() {
        print("Filler")
    }
}
