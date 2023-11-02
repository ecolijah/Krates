import SwiftUI

struct MenuPicker: View {
    @Binding var selectedHomeIndex: Int
    @State private var isExpanded = false
    
    let buttonTitles = ["Albums", "Krates", "Reviews"]
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) { // Alignment set to leading
                ForEach(0..<2) { index in
                    Button(action: {
                        withAnimation {
                            selectedHomeIndex = index
                            isExpanded.toggle()
                        }
                    }) {
                        Text(buttonTitles[index])
                            .fontWeight(.heavy)
                            .font(.title3)
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
            .background(.clear)
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



//#Preview {
//    @State var tmp = 0
//    MenuPicker(selectedHomeIndex: $tmp)
//}
struct MenuPicker_Previews: PreviewProvider {
    static var previews: some View {
        MenuPickerWrapper()
    }
    
    struct MenuPickerWrapper: View {
        @State private var selectedHomeIndex = 0
        
        var body: some View {
            MenuPicker(selectedHomeIndex: $selectedHomeIndex)
        }
    }
}


