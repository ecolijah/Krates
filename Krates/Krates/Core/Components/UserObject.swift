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
    var id: String?
    
    //required after registration
    var email: String
    var fullname: String
    var profileImageUrl: String
    var username: String
    var numLists: Int
    var numLikedAlbums: Int
    var followersCount: Int
    var followingCount: Int
    var numToListenAlbums: Int
    
    
    
    
    //optional
    var bio: String?
    var headerImageUrl: String?
    
    var followers: [String]?
    var following: [String]?

    
    var createdLists: [String]?

    var likedAlbums: [String]?
    var toListenAlbums: [String]?
    var reviews: [String]?
    var likedReviews: [String]?
    var likedLists: [String]?
}
