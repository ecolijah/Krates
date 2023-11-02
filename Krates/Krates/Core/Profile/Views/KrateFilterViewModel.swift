//
//  KrateFilterViewModel.swift
//  Krates
//
//  Created by Eli Lopez on 11/1/23.
//

import Foundation

enum KrateFilterViewModel: Int, CaseIterable {
    case krates
    case likes
//    case reviews
    
    var title: String {
        switch self{
        case.krates: return "Krates"
        case.likes: return "Likes"
//        case.reviews: return "Reviews"
            
        }
    }
}
