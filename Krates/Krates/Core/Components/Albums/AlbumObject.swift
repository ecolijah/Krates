//
//  AlbumObject.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import Foundation

// Main struct representing an album
struct Album: Identifiable, Decodable {
    let id: String
    let name: String
    let releaseDate: String
    let images: [Image]
    let artists: [Artist]

    // Struct for images within an album
    struct Image: Decodable {
        let url: String
        let height: Int
        let width: Int
    }

    // Struct for artists within an album
    struct Artist: Identifiable, Decodable {
        let id: String
        let name: String
        let monthlyListeners: String
    }
}
