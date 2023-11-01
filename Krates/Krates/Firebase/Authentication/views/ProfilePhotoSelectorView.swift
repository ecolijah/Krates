//
//  ProfilePhotoSelectorView.swift
//  Krates
//
//  Created by Eli Lopez on 11/1/23.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel:  AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack { //parent container
            AuthHeaderView(title1: "Setup account.", title2: "Add a profile photo.")
            Button {
                showImagePicker.toggle()
            } label: {
                ZStack {
                    
                    Rectangle()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.brightOrange)
                        .cornerRadius(15)
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 170, height: 170)
                            .scaledToFit()
                            .shadow(color: .gray.opacity(0.3), radius: 15, x: 0, y: 0)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 150, height: 120)
                            .shadow(color: .gray.opacity(0.3), radius: 15, x: 0, y: 0)
                    }
                }
                .frame(width: 200, height: 200)
                .padding()
                .shadow(color: .gray.opacity(0.7), radius: 15, x: 0, y: 0)
                
                    
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            //continue button
            if let selectedImage = selectedImage {
                Button {
                    print("DEBUG: finished registering user.")
                    viewModel.uploadProfileImage(selectedImage)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color.accentDarkGray)
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            }
            // now we need to upload user data
            
            Spacer()
        }.ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedImage =  selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

//private struct ProfileimageModifier: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .resizable()
//            .foregroundColor(Color.white)
//            .frame(width: 150, height: 120)
//            .shadow(color: Color.gray.opacity(0.3), radius: 15, x: 0, y: 0)
//            .clipShape(Circle())
//    }
//}

#Preview {
    ProfilePhotoSelectorView()
}
