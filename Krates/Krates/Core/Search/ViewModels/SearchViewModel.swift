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
    @Published var searchText = ""
    
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            let lowercasedQuery = searchText.lowercased()
            
            return users.filter({
                $0.username.contains(lowercasedQuery) ||
                $0.fullname.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
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
