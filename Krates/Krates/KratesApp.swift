import SwiftUI

@main
struct KratesApp: App {
    
    // Initialize the SpotifyAuthService
    init() {
        SpotifyAuthService.shared.requestAccessToken { token, error in
            if let token = token {
                print("Received Spotify token:", token)
            } else {
                print("Error fetching Spotify token:", error?.localizedDescription ?? "Unknown error")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabControllerView()
        }
    }
}
