//
//  SearchfilterViewModel.swift
//  Krates
//
//  Created by Eli Lopez on 11/2/23.
//

import Foundation

enum SearchFilterViewModel: Int, CaseIterable {
    case users
    case albums
    case krates
    
    var title: String {
        switch self{
        case.users: return "Users"
        case.albums: return "Albums"
        case.krates: return "Krates"
//        case.reviews: return "Reviews"
            
        }
    }
}
