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
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    private var tempUserSession: FirebaseAuth.User?
    
    let userService = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
//        print("DEBUG: user session uid: \(self.userSession?.uid)")
        self.fetchUser()
        

        
    }
    func fetchUser() {
        print("DEBUG: within auth view model fetch user function")
        guard let uid = self.userSession?.uid else { return }
        userService.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
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
            
            self.tempUserSession = user
            
            //upload user data to firestore database
            let data = ["email": email,
                        "fullname": fullname,
                        "username": username]
            
            //upload data to users collection
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    print("DEBUG: did upload user data.")
                    self.didAuthenticateUser = true
                    print("DEBUG: didAuthenticateUser: \(self.didAuthenticateUser)")
                }
            
        }
    }
    func signOut() {
        //log out client side
        userSession = nil
        //log out server side
        try? Auth.auth().signOut()
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                }
            
        }
    }
}
