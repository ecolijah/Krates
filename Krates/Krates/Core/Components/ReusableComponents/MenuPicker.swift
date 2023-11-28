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
                            .fontWeight(selectedHomeIndex == index ? .heavy : .bold)
                            .font(.system(size: 18))
                            .shadow(
                                color: selectedHomeIndex == index ? Color.brightOrange.opacity(0.7) : Color.clear,
                                radius: 3,
                                x: 0,
                                y: 0
                            )

                            

                    }
                    .frame(width: 100, height: 34)
                    .background(selectedHomeIndex == index ? Color.accentDarkGray : Color.accentDarkGray)
                    .foregroundColor(selectedHomeIndex == index ? Color.brightOrange : Color.accentLightGray)
                    .cornerRadius(20)
                    .shadow(
                        color: isExpanded ? Color.black.opacity(0.4) : Color.black.opacity(0.2),
                        radius: isExpanded ? 3 : 2,
                        x: isExpanded ? 10 : 0,
                        y: isExpanded ? 3 : 2
                    )
                    .zIndex(selectedHomeIndex == index ? 1 : 0)
                    // Adjust the offset to ensure expansion is always to the right
                    .offset(x: isExpanded ? CGFloat(index) * 115 : 0)
                }
            }
            .background(.clear)

        }.padding(.vertical)
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


