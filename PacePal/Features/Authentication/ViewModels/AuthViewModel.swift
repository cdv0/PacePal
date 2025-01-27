//
//  AuthViewModel.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/19/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User? // Tells us if we have a user logged in
    @Published var currentUser: User? // Our user object
    
    init() {
        self.userSession = Auth.auth().currentUser // Check if there is a current signed-in user

        Task {
            await fetchUser()
        }
    }
    
    func updateUser(fullName: String? = nil, email: String? = nil) async throws {
        guard let user = userSession else { return }

        do {
            let userID = user.uid
            var updatedData = [String: Any]()
            
            if let fullName = fullName, !fullName.isEmpty, fullName != currentUser?.fullName {
                updatedData["fullName"] = fullName
                self.currentUser?.fullName = fullName
            }
            
            if let email = email, !email.isEmpty, email != currentUser?.email {
                updatedData["email"] = email
                self.currentUser?.email = email
            }
            
            if !updatedData.isEmpty {
                try await Firestore.firestore().collection("users").document(userID).updateData(updatedData)
            }
        } catch {
            print("DEBUG: Failed to update user with error \(error.localizedDescription)")
        }
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser() // After we create the user, fetch that user immediately to display to the screen
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }

    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }

    }
    
    func deleteAccount(withEmail email: String, password: String) async{
        guard let user = userSession else { return }
        do {
            // Reauthenticate ethe user
            await reauthenticateUser(withEmail: email, password: password)
            
            // Delete the Firestore document
            let userID = user.uid
            try await Firestore.firestore().collection("users").document(userID).delete()
            
            // Delete the FirebaseAuth user
            guard let user = userSession else { return }
            try await user.delete()
            
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to delete account with error \(error.localizedDescription)")
        }
    }
    
    func reauthenticateUser(withEmail email: String, password: String) async {
        guard let user = userSession else { return }
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        do {
            try await user.reauthenticate(with: credential)
        } catch {
            print("DEBUG: Failed to reauthenticate user with error \(error.localizedDescription)")
        }
    }
    
    func sendPasswordReset(withEmail email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            print("DEBUG: Failed to send password reset with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }  // Get the current user's id
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }// Do not care much about handling error here since things typically work here
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG: Current user is \(self.currentUser)")
    }
}
