//
//  HomeKratesView.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import SwiftUI

struct HomeKratesView: View {

    var body: some View {
        VStack(alignment: .leading) {
            MenuPicker()
            
            ScrollView() {
                LazyVStack(spacing: 0) {
                    ForEach(0..<5) { index in
                        KrateRowCell()
                    }
                }
            }
        }
        .background(Color.background)

    }
}

#Preview {
    HomeKratesView()
}
