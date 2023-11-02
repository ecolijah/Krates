//
//  UserObject.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    
    //documentid in datbase
    @DocumentID  var id: String?
    
    //required after registration
    var username: String
    var fullname: String
    var profileImageUrl: String
    var email: String
    
     //optional
    var bio: String?
    var headerImageUrl: String?
    
    var followers: [String]?
    var following: [String]?
    
    var createdLists: [String]?
    var likedAlbums: [String]?
    var reviews: [String]?
    var likedReviews: [String]?
    var likedLists: [String]?
}
