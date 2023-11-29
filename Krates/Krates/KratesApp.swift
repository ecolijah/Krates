import SwiftUI
import Firebase



@main
struct KratesApp: App {
    //init a viewmodel instance, enviroenment so only init once
    @StateObject var viewModel = AuthViewModel()
    
    // Initialize the SpotifyAuthService
    init() {
        //Firebase app initialization
        FirebaseApp.configure()
        //Spotfiy APi Initialization, getting token
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
            NavigationView {
                ContentView()
            }
            .environmentObject(viewModel)
        }
    }
}
