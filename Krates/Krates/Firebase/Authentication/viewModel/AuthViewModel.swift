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
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error = error {
                print("DEBUG: Failed to sign in user. \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("DEBUG: Did log user in.")
        }
    }
    func register(withEmail email: String, password: String, fullname: String, username: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to create user. \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("DEBUG: Registered user successfully.")
            print("User uid id: \(user.uid)")
            
            //upload user data to firestore database
            let data = ["email": email,
                        "password": password.lowercased(),
                        "fullname": fullname,
                        "username": username,
                        "uid": user.uid]
            
            //upload data to users collection
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    print("DEBUG: did upload user data.")
                }
        }
    }
    func signOut() {
        //log out client side
        userSession = nil
        //log out server side
        try? Auth.auth().signOut()
    }
}
