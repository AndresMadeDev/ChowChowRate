//
//  AuthViewModel.swift
//  GrubRate
//
//  Created by Andres Made on 4/15/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocal {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUserData()
        }
    }
    
    func signIn(email: String, password: String) async throws {
        do {
           let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUserData()
        } catch {
            self.showError = true
            self.errorMessage = "Sign In Error \(error.localizedDescription)"
        }
    }
    
    func creatUser(email: String, userName: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, username: userName, email: email)
            let encodeUser = try Firestore.Encoder().encode(user) 
            try await Firestore.firestore().collection("user").document(user.id).setData(encodeUser)
            await fetchUserData()
        } catch {
            showError = true
            errorMessage = "Sign In Error \(error.localizedDescription)"
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            
        }
        
    }
    
    func resetPassword(email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            print("EMAIL SENT TO \(email)")
        } catch {
            print("ERROR SENING RESET EMAIL")
        }
    }
    
    func deleteAccount() {
        
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
            // An error happened.
          } else {
            print("ACCOUNT DELETED")
              self.userSession = nil
              self.currentUser = nil
          }
        }
        
    }
    
    func fetchUserData() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapShot = try? await Firestore.firestore().collection("user").document(uid).getDocument() else { return }
        self.currentUser = try? snapShot.data(as: User.self)
    }
    
}
