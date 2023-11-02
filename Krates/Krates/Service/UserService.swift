//
//  UserService.swift
//  Krates
//
//  Created by Eli Lopez on 11/1/23.
//


import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String) {
        print("DEBUG: within user service fetch function")
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                //for printing data
                guard let snapshot = snapshot else {
                    return
                }
                guard let user = try? snapshot.data(as: User.self) else { 
                    print("no snapshot")
                    return }
                
                print("DEBUG: User name is: \(user.username)")
                
            }
        
    }
}
