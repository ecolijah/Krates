//
//  KrateService.swift
//  Krates
//
//  Created by Eli Lopez on 11/2/23.
//

import Foundation
import Firebase
//import FirebaseFirestore

struct KrateService {
    
    func uploadKrate(krateName: String, krateDesc: String, krateAlbums: [String]) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "krateName": krateName,
                    "krateDescription": krateDesc,
                    "krateAlbums": krateAlbums] as [String : Any]
        
        //upload data
        Firestore.firestore().collection("krates")
            .document()
            .setData(data) { _ in
                print("DEBUG: did upload krate")
            }
    }
}
