//
//  ContentView.swift
//  Krates
//
//  Created by Eli Lopez on 10/31/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        Group {
            if viewModel.userSession == nil {
                //no usr logged in
                LoginView()
            } else {
                //user logged in
                TabControllerView()
            }
        }
    }
}

#Preview {
    ContentView()
}
