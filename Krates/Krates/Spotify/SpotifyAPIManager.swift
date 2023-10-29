import Foundation

class SpotifyAPIManager {
    
    private let baseURL = "https://api.spotify.com/v1"
    private let authService = SpotifyAuthService.shared
    
    //main home view album lists
    private let newReleasesList = ["spotify:album:4CIaS88EQ6j26qOigblqSH",
                                   "spotify:album:4CIaS88EQ6j26qOigblqSH",
                                   "spotify:album:4CIaS88EQ6j26qOigblqSH",
                                   "spotify:album:4CIaS88EQ6j26qOigblqSH",
                                   "spotify:album:4CIaS88EQ6j26qOigblqSH",
                                   "spotify:album:4CIaS88EQ6j26qOigblqSH"]
    
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
    
    struct SpotifyAlbumsResponse: Codable {
        let albums: SpotifyAlbumPage
    }

    struct SpotifyAlbumPage: Codable {
        let items: [Album]
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

