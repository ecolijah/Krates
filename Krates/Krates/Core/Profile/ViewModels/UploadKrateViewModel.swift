//
//  UploadKrateViewModel.swift
//  Krates
//
//  Created by Eli Lopez on 11/2/23.
//

import Foundation

class UploadKrateViewModel: ObservableObject {
    
    let service = KrateService()
    
    func uploadKrate(withKrateName krateName: String, krateDesc: String, krateAlbums: [String]) {
        service.uploadKrate(krateName: krateName, krateDesc: krateDesc, krateAlbums: krateAlbums)
    }
}
