//
//  RegisterView.swift
//  Krates
//
//  Created by Eli Lopez on 10/31/23.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var username = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack { //parentview
            AuthHeaderView(title1: "Get started.", title2: "Create your account")
            VStack (spacing: 40) {
                CustomInputField(imageName: "envelope", placeHoldertext: "Email", text: $email)
                
                CustomInputField(imageName: "person", placeHoldertext: "Username", text: $username)
                
                CustomInputField(imageName: "person", placeHoldertext: "Full name", text: $fullname)

                CustomInputField(imageName: "lock", placeHoldertext: "Password", text: $password)
            }
            .padding(32)
            
            Button {
                viewModel.register(withEmail: email, password: password, fullname: fullname, username: username)
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color.accentDarkGray)
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.accentLightGray)
                    
                    Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.accentDarkGray)
                }
            }.padding(.bottom, 32)
            
        }.ignoresSafeArea()
    }
}

#Preview {
    RegisterView()
}
