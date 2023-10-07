import SwiftUI

struct MenuPicker: View {
    @State private var selectedHomeIndex = 0
    @State private var isExpanded = false
    
    let buttonTitles = ["Albums", "Krates", "Reviews"]
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) { // Alignment set to leading
                ForEach(0..<3) { index in
                    Button(action: {
                        withAnimation {
                            selectedHomeIndex = index
                            isExpanded.toggle()
                        }
                    }) {
                        Text(buttonTitles[index])
                            .bold()
                            .font(.title2)
                    }
                    .frame(width: 120, height: 40)
                    .background(selectedHomeIndex == index ? Color.accentDarkGray : Color.accentDarkGray)
                    .foregroundColor(selectedHomeIndex == index ? Color.brightOrange : Color.accentLightGray)
                    .cornerRadius(20)
                    .shadow(
                        color: isExpanded ? Color.black.opacity(0.4) : Color.black.opacity(0.4),
                        radius: isExpanded ? 3 : 2,
                        x: isExpanded ? 10 : 0,
                        y: isExpanded ? 3 : 2
                    )
                    .zIndex(selectedHomeIndex == index ? 1 : 0)
                    // Adjust the offset to ensure expansion is always to the right
                    .offset(x: isExpanded ? CGFloat(index) * 125 : 0)
                }
            }
            // Conditionally displaying the related view
//            if selectedHomeIndex == 0 {
//                HomeAlbumsView()
//            } else if selectedHomeIndex == 1 {
//                HomeKratesView()
//            } else if selectedHomeIndex == 2 {
//                HomeReviewsView()
//            }

        }
    }
}

#Preview {
    MenuPicker()
}
