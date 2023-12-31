import Foundation

class SpotifyAPIManager {
    
    private let baseURL = "https://api.spotify.com/v1"
    private let authService = SpotifyAuthService.shared
    
    //main home view album lists
    private let newReleasesList = ["spotify:album:2pOEFqvfxp5uUQ8vQEmVA0",
                                   "spotify:album:2QZMOZaXCN7GQjr3qKWAwA",
                                   "spotify:album:7CHNUgkepqsMm9tYnwtVDt",
                                   "spotify:album:33Ek6daAL3oXyQIV1uoItD",
                                   "spotify:album:6LrhvefGM7zcJpIdMC9otz",
                                   "spotify:album:3bKp9TUgbHGhfRBsTQTAxS"]
    
    private let popularList = ["spotify:album:4FftCsAcXXD1nFO9RFUNFO",
                               "spotify:album:4czdORdCWP9umpbhFXK2fW",
                               "spotify:album:63fWdGyeBj8VDjvHSUROx3",
                               "spotify:album:6PbnGueEO6LGodPfvNldYf",
                               "spotify:album:1D1hLipjrdB6pnxurMtC3E",
                               "spotify:album:6i7mF7whyRJuLJ4ogbH2wh"]
    
    private let recommendedList = ["spotify:album:4CIaS88EQ6j26qOigblqSH",
                                   "spotify:album:4p73PcjJvWer7WDYXcGetn",
                                   "spotify:album:5YrOTxB5pmtK6uD4qcpAw5",
                                   "spotify:album:7EV6GsiM2nvt38n2FnnpEj",
                                   "spotify:album:2tAFOhqz3DxxVI2s5YNsrD",
                                   "spotify:album:0agALBMd2a8cnpbpukTg03"]
    
    
    //these 2 are trivial and used for decoding json easier

    
    func fetchAlbumsForArtist(withId artistId: String, completion: @escaping ([String]?, Error?) -> Void) {
        print("Fetching albums for artist ID:", artistId)
        makeRequest(endpoint: "artists/\(artistId)/albums") { data, error in
            guard let data = data, error == nil else {
                print("Error fetching albums for artist ID \(artistId):", error?.localizedDescription ?? "Unknown error")
                completion(nil, error)
                return
            }
            // Directly extract album URIs from the raw JSON
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let items = jsonObject["items"] as? [[String: Any]] {
                let albumURIs = items.compactMap { item -> String? in
                    if let albumType = item["album_type"] as? String, albumType == "album",
                       let uri = item["uri"] as? String {
                        return uri
                    }
                    return nil
                }
                print("Fetched albums for artist ID \(artistId) successfully!")
                completion(albumURIs, nil)
            } else {
                print("Failed to parse albums JSON for artist ID \(artistId): Unexpected JSON structure")
                completion(nil, NSError(domain: "com.yourapp", code: 9999, userInfo: [NSLocalizedDescriptionKey: "Unexpected JSON structure"]))
            }
        }
    }




    
    
    func fetchAlbumsInKrate(krateAlbums: [String], completion: @escaping ([Album]?, Error?) -> Void) {
        print("Fetching albums...")
        var albums: [Album] = []
        let group = DispatchGroup()
        
        for uri in krateAlbums {
            group.enter()
            fetchAlbum(for: uri) { album, error in
                if let album = album {
                    albums.append(album)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("Completed fetching albums in krate!")
            completion(albums, nil)
        }
    }
    
    
    func fetchNewReleases(completion: @escaping ([Album]?, Error?) -> Void) {
        print("Fetching recommended albums...")
        var albums: [Album] = []
        let group = DispatchGroup()
        
        for uri in newReleasesList {
            group.enter()
            fetchAlbum(for: uri) { album, error in
                if let album = album {
                    albums.append(album)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("Completed fetching new release albums!")
            completion(albums, nil)
        }
    }
        
    func fetchRecommended(completion: @escaping ([Album]?, Error?) -> Void) {
        print("Fetching recommended albums...")
        var albums: [Album] = []
        let group = DispatchGroup()
        
        for uri in recommendedList {
            group.enter()
            fetchAlbum(for: uri) { album, error in
                if let album = album {
                    albums.append(album)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("Completed fetching recommended albums!")
            completion(albums, nil)
        }
    }
    
    func fetchPopular(completion: @escaping ([Album]?, Error?) -> Void) {
        print("Fetching recommended albums...")
        var albums: [Album] = []
        let group = DispatchGroup()
        
        for uri in popularList {
            group.enter()
            fetchAlbum(for: uri) { album, error in
                if let album = album {
                    albums.append(album)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("Completed fetching popular albums!")
            completion(albums, nil)
        }
    }
    
    func fetchArtistInfo(for artistId: String, completion: @escaping (ArtistObject?, Error?) -> Void) {
        print("Fetching artist info for ID:", artistId)
        makeRequest(endpoint: "artists/\(artistId)") { data, error in
            guard let data = data, error == nil else {
                print("Error fetching artist for ID \(artistId):", error?.localizedDescription ?? "Unknown error")
                completion(nil, error)
                return
            }
            do {
                print(String(data: data, encoding: .utf8) ?? "Invalid data")

                let decodedArtist = try JSONDecoder().decode(ArtistObject.self, from: data)
                print("Fetched artist for ID \(artistId) successfully!")
                completion(decodedArtist, nil)
            } catch {
                print("Failed to parse artist JSON for ID \(artistId):", error)
                completion(nil, error)
            }
        }
    }
    
    func searchAlbums(query: String, completion: @escaping ([Album]?, Error?) -> Void) {
        print("Searching for albums with query:", query)
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let endpoint = "search?q=\(encodedQuery)&type=album&limit=10" // Limit to the top 10 results

        makeRequest(endpoint: endpoint) { data, error in
            guard let data = data, error == nil else {
                print("Error searching for albums with query \(query):", error?.localizedDescription ?? "Unknown error")
                completion(nil, error)
                return
            }

            do {
                // prints album json for testing
                print("DEBUG: got data")
                print(String(data: data, encoding: .utf8) ?? "Invalid data")
                let decodedResponse = try JSONDecoder().decode(SpotifyAlbumsResponse.self, from: data)
                let albums = decodedResponse.albums?.items
                print("Found \(albums?.count) albums with query \(query)")
                completion(albums, nil)
            } catch {
                print("DEBUG:not got data")

                print("Failed to parse search results for query \(query):", error)
                completion(nil, error)
            }
        }
    }


    
    
    //private base helper functions for getting album json data and populating album objects
    private func fetchAlbum(for uri: String, completion: @escaping (Album?, Error?) -> Void) {
        print("Fetching album for URI:", uri)
        let albumID = uri.replacingOccurrences(of: "spotify:album:", with: "")
        makeRequest(endpoint: "albums/\(albumID)") { data, error in
            guard let data = data, error == nil else {
                print("Error fetching album for URI \(uri):", error?.localizedDescription ?? "Unknown error")
                completion(nil, error)
                return
            }
            do {
                // prints album json for testing
//                print(String(data: data, encoding: .utf8) ?? "Invalid data")

                let decodedAlbum = try JSONDecoder().decode(Album.self, from: data)
                print("Fetched album for URI \(uri) successfully!")
                completion(decodedAlbum, nil)
            } catch {
                print("Failed to parse album JSON for URI \(uri):", error)
                completion(nil, error)
            }
        }
    }
    
    private func makeRequest(endpoint: String, completion: @escaping (Data?, Error?) -> Void) {
            // Check if the token is nil
            if authService.currentToken == nil {
                // Request a new token
                authService.requestAccessToken { token, error in
                    if let token = token {
                        self.performRequest(endpoint: endpoint, completion: completion)
                    } else {
                        completion(nil, error)
                    }
                }
            } else {
                performRequest(endpoint: endpoint, completion: completion)
            }
        }
    private func performRequest(endpoint: String, completion: @escaping (Data?, Error?) -> Void) {
            guard let url = URL(string: "\(baseURL)/\(endpoint)") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(authService.currentToken!)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                    // Token might be expired. Fetch a new token and retry the request
                    self.authService.requestAccessToken { token, error in
                        if let token = token {
                            self.performRequest(endpoint: endpoint, completion: completion)
                        } else {
                            completion(nil, error)
                        }
                    }
                } else {
                    completion(data, error)
                }
            }
            task.resume()
    }
    
    
}

