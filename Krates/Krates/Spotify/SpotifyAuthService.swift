import Foundation

class SpotifyAuthService {
    
    private let clientID: String
    private let clientSecret: String
    private let tokenURL = "https://accounts.spotify.com/api/token"
    private var accessToken: String?
    
    // Private initializer to prevent multiple instances
    private init(clientID: String, clientSecret: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret
    }
    
    // Singleton instance
    static let shared = SpotifyAuthService(clientID: "17e5496772f04404bfe69e6507344ccc", clientSecret: "70179e6e81a247258408d4ace9855570")
    
    var currentToken: String? {
        return accessToken
    }
    
    func requestAccessToken(completion: @escaping (String?, Error?) -> Void) {
        guard let url = URL(string: tokenURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64EncodedCredentials())", forHTTPHeaderField: "Authorization")
        let bodyData = "grant_type=client_credentials"
        request.httpBody = bodyData.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                if let token = result?["access_token"] as? String {
                    self.accessToken = token
                    completion(token, nil)
                } else {
                    completion(nil, error)
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    private func base64EncodedCredentials() -> String {
        let credentials = "\(clientID):\(clientSecret)"
        return Data(credentials.utf8).base64EncodedString()
    }
}
