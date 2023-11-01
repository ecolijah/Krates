//
//  ProfileView.swift
//  Krates
//
//  Created by Eli Lopez on 10/4/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ProfileHeader()
            ScrollView {
                VStack(spacing: 0) {
                    ProfileInfo()
                    Rectangle()
                        .foregroundColor(Color.background)
                        .frame(height: 800)
                }
            }
            .ignoresSafeArea(.all)
        }
    }
}


struct ProfileHeader: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.background]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea(.all, edges: .top)
                
                HStack {
                    
                    Button { //temporary logout button
                        viewModel.signOut()
                    } label: {
                        Rectangle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    }
                    Spacer()
                    
                    Text("Profile")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.whiteFont) // Modify as per your color scheme
                        .shadow(color: Color.black.opacity(0.8), radius: 20, x: 10, y: 10)
                    
                    Spacer()
                    
                    // Filter settings
                    Button(action: {
                        // Filter button action
                    }) {
                        Image("icons8-three-dots-50")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.accentLightGray) // Modify as per your color scheme
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 50)
            
        }
        .background(Color.background)
    }
}

struct ProfileInfo: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack(alignment: .leading)  {
            // header image goes here
            Image("profilebackgroundtusks")
                .frame(width: 340, height: 200)
            
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.background]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all, edges: .top)
                .frame(height: 280)
            
            VStack {
                
                Spacer()
                
                HStack(alignment: .center) {
                    
                    Circle()
                        .frame(width: 140)
                        .padding()
                        .shadow(radius: 10)
                        .foregroundColor(Color.accentLightGray)
                    
                    VStack (alignment: .leading) {
                        // following icon
                        Image("dummy")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(2)
                        //user name
                        Text("username")
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.whiteFont)
                            .padding(2)
                            .shadow(radius: 4)

                        
                        HStack() {
                            Text("20 lists")
                                .font(.caption)
                                .fontWeight(.heavy)
                                .foregroundColor(.accentLightGray)
                                .padding(2)


                            Text("1.4k albums")
                                .fontWeight(.heavy)
                                .font(.caption)
                                .foregroundColor(.accentLightGray)
                                .padding(2)

                        }
                        
                        HStack {
                            Text("100 followers")
                                .font(.caption)
                                .fontWeight(.heavy)
                                .foregroundColor(.accentLightGray)
                                .padding(2)

                            Text("200 following")
                                .font(.caption)
                                .fontWeight(.heavy)
                                .foregroundColor(.accentLightGray)
                                .padding(2)
                        }
                        
                        
                    }
                    
                }
                
            }
            .frame(height: 280)
            
                
        }
    }
}
#Preview {
    ProfileView()
}
