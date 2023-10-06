//
//  UserObject.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import Foundation
import SwiftUI

struct User: Identifiable {
    
    var id: UUID
    var username: String
    var bio: String
    var profilePic: Image
    var header: Image
    
    var followers: [User]
    var following: [User]
    
    var createdLists: [Krate]
    var likedAlbums: [Album]
    var reviews: [Review]
    var likedReviews: [Review]
    var likedLists: [Krate]
}
