//
//  AlbumObject.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import Foundation

struct SpotifyAlbumsResponse: Codable {
    let albums: AlbumsData
}

struct AlbumsData: Codable {
    let items: [Album]
}

struct Album: Codable, Identifiable {
    let id: String
    let name: String
    let artists: [Artist]
    let images: [AlbumImage]
    let release_date: String
    let total_tracks: Int
    let external_urls: [String: String]
    
    // We can add a computed property to get the first artist name if needed
    var primaryArtistName: String? {
        return artists.first?.name
    }

    // And similarly, a computed property to get the main image URL (based on your provided JSON, it seems the first image is the largest)
    var primaryImageURL: URL? {
        if let urlString = images.first?.url {
            return URL(string: urlString)
        }
        return nil
    }
}

struct Artist: Codable {
    let name: String
    let external_urls: [String: String]
}

struct AlbumImage: Codable {
    let url: String
    let width: Int
    let height: Int
}
