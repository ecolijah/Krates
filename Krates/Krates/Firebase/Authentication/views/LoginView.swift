//
//  LoginView.swift
//  Krates
//
//  Created by Eli Lopez on 10/31/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack { //parent container
            
            AuthHeaderView(title1: "Hello.", title2: "Welcome back.")
            
            VStack (spacing: 40){ //login info
//                TextField("Email", text: $email)
                CustomInputField(imageName: "envelope", placeHoldertext: "Email", text: $email)
                
//                TextField("Password", text: $password)
                CustomInputField(imageName: "lock", placeHoldertext: "Password", text: $password)
            }
            .padding(.horizontal, 32)
            .padding(.top, 40)
            
            HStack {
                Spacer()
                
                NavigationLink {
                    Text("reset password view")
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.brightOrange)
                        .padding(.top)
                        .padding(.trailing, 24)
                }
            }
            Button {
                //sign in
                viewModel.login(withEmail: email, password: password)
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color.accentDarkGray)
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            NavigationLink {
                RegisterView()
                    .navigationBarHidden(true)
            } label: {
                HStack {
                    Text("Dont have an account?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Text("Sign Up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.accentDarkGray)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(.accentLightGray)
            
            
            
        }
        .ignoresSafeArea()
        .navigationBarHidden(false)
    }
}

#Preview {
    LoginView()
}
