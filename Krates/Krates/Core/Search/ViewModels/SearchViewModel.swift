//
//  SearchViewModel.swift
//  Krates
//
//  Created by Eli Lopez on 11/2/23.
//

import Foundation
class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    let service = UserService()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
            print("DEBUG: Users \(users)")
        }
    }
}
