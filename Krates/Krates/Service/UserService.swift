import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void ) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                if let error = error {
                    print("DEBUG: Error fetching user:", error.localizedDescription)
                    return
                }
                
//                print("DEBUG: within user service fetch function, uid: \(uid)")

                guard let snapshot = snapshot, let data = snapshot.data() else {
                    print("DEBUG: Snapshot might be nil or no data available")
                    return
                }

                // Print the Firestore data
//                print("DEBUG: Firestore data:", data)

                // Use the do-catch block for decoding
                do {
                    var user = try Firestore.Decoder().decode(User.self, from: data)
                    user.id = snapshot.documentID
                    print("DEBUG: User name is: \(user.username)")
                    completion(user)
                } catch {
                    print("DEBUG: Decoding error:", error)
                }
            }
    }
}
