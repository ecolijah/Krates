//
//  CustomInputField.swift
//  Krates
//
//  Created by Eli Lopez on 10/31/23.
//

import SwiftUI

struct CustomInputField: View {
    let imageName: String
    let placeHoldertext: String
    @Binding var text: String
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.accentDarkGray)
                TextField(placeHoldertext, text: $text)
            }
            
            Divider()
                .background(Color.divider)
        }
    }
}

#Preview {
    CustomInputField(imageName: "envelope", placeHoldertext: "Email", text: .constant(""))
}
