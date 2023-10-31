//
//  AuthViewModel.swift
//  Krates
//
//  Created by Eli Lopez on 10/31/23.
//
import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: User session is \(String(describing: self.userSession))")
    }
    
    func login(withEmail email: String, password: String) {
        print("DEBUG: login with email \(email)")
    }
    func register(withEmail email: String, password: String, fullname: String, username: String){
        print("DEBUG: register with email \(email)")

    }
}
