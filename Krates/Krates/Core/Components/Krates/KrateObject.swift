//
//  KrateObject.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import Foundation

struct Krate: Identifiable{
    
    var id: UUID
    var name: String
    var author: String
    var dateCreated: Date
    var likes: Int
    var comments: [krateComment]?
    var description: String
    var albums: [String] //array of spotify uris
    var headerImage: URL?
    
}

struct krateComment: Identifiable{
    var id: UUID
    var author: String
    var text: String
    var datePosted: Date
}
