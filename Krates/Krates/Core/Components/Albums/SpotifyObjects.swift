import Foundation

struct Album: Codable {
    let albumType: String
    let totalTracks: Int
    let availableMarkets: [String]
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [AlbumImage]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: String
    let restrictions: Restriction?
    let type: String
    let uri: String
    let artists: [Artist]
    let tracks: TrackCollection?
    let copyrights: [Copyright]
    let externalIds: ExternalIds
    let genres: [String]
    let label: String
    let popularity: Int
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case restrictions, type, uri, artists, tracks, copyrights
        case externalIds = "external_ids"
        case genres, label, popularity
    }
}

struct ExternalUrls: Codable {
    let spotify: String
}

struct AlbumImage: Codable {
    let url: String
    let height: Int
    let width: Int
}

struct Artist: Codable {
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let name: String
    let type: String
    let uri: String
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

struct Restriction: Codable {
    let reason: String
}

struct TrackCollection: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [Track]
}

struct Track: Codable {
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber: Int
    let durationMs: Int
    let explicit: Bool
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let isPlayable: Bool?
    let linkedFrom: LinkedFrom?
    let restrictions: Restriction?
    let name: String
    let previewUrl: String?
    let trackNumber: Int
    let type: String
    let uri: String
    let isLocal: Bool
    
    enum CodingKeys: String, CodingKey {
        case artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMs = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case href, id
        case isPlayable = "is_playable"
        case linkedFrom = "linked_from"
        case restrictions, name
        case previewUrl = "preview_url"
        case trackNumber = "track_number"
        case type, uri
        case isLocal = "is_local"
    }
}

struct LinkedFrom: Codable {
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let type: String
    let uri: String
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, type, uri
    }
}

struct Copyright: Codable {
    let text: String
    let type: String
}

struct ExternalIds: Codable {
    let isrc: String?
    let ean: String?
    let upc: String?
}

struct ArtistObject: Codable {
    let externalUrls: ExternalUrls?
    let followers: Followers
    let genres: [String]
    let href: String
    let id: String
    let images: [ArtistImage]
    let name: String
    let popularity: Int
    let type: String
    let uri: String

    struct ExternalUrls: Codable {
        let spotify: String
    }

    struct Followers: Codable {
        let href: String?
        let total: Int
    }

    struct ArtistImage: Codable {
        let url: String
        let height: Int
        let width: Int
    }
}

