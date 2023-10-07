//
//  KrateObject.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import Foundation

struct Krate: Identifiable, Decodable {
    var id: UUID
    var name: String
    var author: String
    var dateCreated: Date
    var likes: Int
    var comments: [krateComment]
    var description: String
    var albums: [Album]
    
}

struct krateComment: Identifiable, Codable {
    var id: UUID
    var author: String
    var text: String
    var datePosted: Date
}
