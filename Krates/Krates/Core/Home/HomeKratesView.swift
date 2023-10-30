//
//  HomeKratesView.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import SwiftUI

struct HomeKratesView: View {
    var krate1 = Krate(
        id: UUID(),
        name: "shoegazer",
        author: "ecolijah",
        dateCreated: Date(),
        likes: 3, 
        description: "Description",
        albums: ["spotify:album:4CIaS88EQ6j26qOigblqSH",
                 "spotify:album:4p73PcjJvWer7WDYXcGetn",
                  "spotify:album:5YrOTxB5pmtK6uD4qcpAw5",
                  "spotify:album:7EV6GsiM2nvt38n2FnnpEj",
                  "spotify:album:2tAFOhqz3DxxVI2s5YNsrD",
                  "spotify:album:0agALBMd2a8cnpbpukTg03"])
    
    @Binding var menuShowing: Bool
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                ScrollView() {
                    LazyVStack(spacing: 0) {
                        ForEach(0..<5) { _ in
                            KrateRowCell(menuShowing: $menuShowing, krate: krate1)
                        }
                    }
                }
            }
            .background(Color.background)
        }
        

    }
}

#Preview {
    HomeKratesView(menuShowing: .constant(false))
}
