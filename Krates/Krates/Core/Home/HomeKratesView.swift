//
//  HomeKratesView.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import SwiftUI

struct HomeKratesView: View {
    var krateArray: [Krate] = [
            Krate(id: UUID(), name: "shoegazer", author: "ecolijah", dateCreated: Date(), likes: 3, description: "my favorite shoegaze albums", albums: ["spotify:album:4CIaS88EQ6j26qOigblqSH", "spotify:album:4p73PcjJvWer7WDYXcGetn", "spotify:album:5YrOTxB5pmtK6uD4qcpAw5", "spotify:album:7EV6GsiM2nvt38n2FnnpEj", "spotify:album:2tAFOhqz3DxxVI2s5YNsrD", "spotify:album:0agALBMd2a8cnpbpukTg03"]),
            Krate(id: UUID(), name: "synthetic feathers", author: "optic_occ", dateCreated: Date(), likes: 3, description: "a collection of my favorite new albums from 2023.", albums: ["spotify:album:2pOEFqvfxp5uUQ8vQEmVA0", "spotify:album:2QZMOZaXCN7GQjr3qKWAwA", "spotify:album:7CHNUgkepqsMm9tYnwtVDt", "spotify:album:33Ek6daAL3oXyQIV1uoItD", "spotify:album:6LrhvefGM7zcJpIdMC9otz", "spotify:album:3bKp9TUgbHGhfRBsTQTAxS"]),
            Krate(id: UUID(), name: "alien clubs", author: "scy_gth", dateCreated: Date(), likes: 3, description: "club music from different universes.", albums: ["spotify:album:2nbzU31fL3LKoaPSNTRUin", "spotify:album:2DxpJIKyX1LYOTWX5qiiiY", "spotify:album:6Pw0lHRw1j1eCBuodm93ZD", "spotify:album:7EV6GsiM2nvt38n2FnnpEj", "spotify:album:4mwrMLVKo940qLFXEIef4w", "spotify:album:0agALBMd2a8cnpbpukTg03",
                                                                                                                                                "spotify:album:2nbzU31fL3LKoaPSNTRUin", "spotify:album:2DxpJIKyX1LYOTWX5qiiiY", "spotify:album:6Pw0lHRw1j1eCBuodm93ZD", "spotify:album:7EV6GsiM2nvt38n2FnnpEj", "spotify:album:4mwrMLVKo940qLFXEIef4w", "spotify:album:0agALBMd2a8cnpbpukTg03"]),
            Krate(id: UUID(), name: "adventure soundtrack", author: "landlord", dateCreated: Date(), likes: 3, description: "albums that inspire new adventures.", albums: ["spotify:album:4CIaS88EQ6j26qOigblqSH", "spotify:album:4p73PcjJvWer7WDYXcGetn", "spotify:album:5YrOTxB5pmtK6uD4qcpAw5", "spotify:album:7EV6GsiM2nvt38n2FnnpEj", "spotify:album:2tAFOhqz3DxxVI2s5YNsrD", "spotify:album:0agALBMd2a8cnpbpukTg03"])
        ]
    
    @Binding var menuShowing: Bool
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                ScrollView() {
                    LazyVStack(spacing: 0) {
                        ForEach(krateArray) { krate in
                            KrateRowCell(menuShowing: $menuShowing, krate: krate)
                        }
                    }
                }
            }
            .background(Color.background)
            .onAppear {
                if !menuShowing {
                    menuShowing = true
                }
            }
        }
        

    }
}

#Preview {
    HomeKratesView(menuShowing: .constant(false))
}
