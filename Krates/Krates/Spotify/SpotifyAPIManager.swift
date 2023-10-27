import Foundation

class SpotifyAPIManager {
    
    private let baseURL = "https://api.spotify.com/v1"
    
    func fetchNewReleases(completion: @escaping ([Album]?, Error?) -> Void) {
        makeRequest(endpoint: "albums/new-releases?limit=10") { data, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(SpotifyAlbumsResponse.self, from: data)
                completion(decodedResponse.albums.items, nil)
            } catch {
                print("Failed to parse JSON:", error)
                completion(nil, error)
            }
        }
    }
    
    private func makeRequest(endpoint: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(endpoint)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(SpotifyAuthService.shared.currentToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, error)
        }
        task.resume()
    }
}
