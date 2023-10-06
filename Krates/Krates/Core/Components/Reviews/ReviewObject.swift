//
//  ReviewObject.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import Foundation

struct Review: Identifiable, Decodable {
    var id: UUID
    var rating: Int
    var title: String
    var author: String
    var album: Album
    var description: String
}

struct reviewComment: Identifiable, Decodable {
    var id: UUID
    var author: String
}
