//
//  SocialView.swift
//  Krates
//
//  Created by Eli Lopez on 10/4/23.
//

import SwiftUI

struct SocialView: View {
    @State private var selectedIndex = 0
    let buttons: [String] = ["Friends", "You", "Incoming"]

    var body: some View {
        VStack {
            
            VStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.background]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea(.all, edges: .top)
                    
                    HStack {
                        Rectangle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.clear)
                        Spacer()
                        
                        Text("Social")
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
                
            
            // Header View
            

            // Notifications Menu
            HStack(spacing: 16) {
                
                Spacer()
                
                ForEach(0..<3) { index in
                    
                    Spacer()
                    
                    Button(action: {
                        selectedIndex = index
                    }) {
                        Text(buttons[index])
                            .font(.system(size: 12))
                            .foregroundColor(selectedIndex == index ? Color.brightOrange : Color.accentLightGray)
                            .fontWeight(.heavy)
                    }
                    
                    Spacer()
                    
                    // Add a divider unless it's the last button
                    if index < buttons.count - 1 {
                        Divider()
                            .background(Color.accentLightGray)  // Assuming a custom color
                            .frame(height: 25)
                            .padding(.vertical, 4)
                    }
                    
                }
                
                Spacer()
            }
            .background(Color.accentDarkGray)  // Assuming a custom color
            .cornerRadius(10)
            .padding(.horizontal, 4)

            //for spacing purposes
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color.background)

            // Notifications View
            NotificationsView(notifIndex: $selectedIndex)
        }
        .background(Color.background)  // Assuming a custom color
    }
}

struct NotificationsView: View {
    @Binding var notifIndex: Int
    let notifTypes: [String] = ["Friends","You","Incoming"]
    var body: some View {
        
//        Text(notifTypes[notifIndex])
//            .foregroundColor(.whiteFont)
        ScrollView {
            VStack(spacing: 0) {
                ForEach(0..<4) { index in
                    HorizontalNotificationsCell()
                    
                }
            }
        }
        .background(Color.background)
    }
}

struct HorizontalNotificationsCell: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.accentLightGray)
                    .padding(.horizontal, 4)
                Text("Opticoccasions liked your list: 'PS2 DnB'")
                    .foregroundColor(.accentLightGray)
                    .font(.caption)
                Spacer()
                Text("2h")
                    .foregroundColor(.accentLightGray)
                    .font(.caption)
       
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.accentDarkGray)
//            .background(Color.background)
            
            Rectangle()
                .fill(Color.background) // Choose your desired color
                .frame(height: 2)
                .cornerRadius(1)
         
        }
        .cornerRadius(10)
        .padding(.horizontal, 4)
        
    }
}

#Preview {
    SocialView()
}
