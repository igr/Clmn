import SwiftUI

struct TaskColorRadioButtons: View {

    let colors: [Color] = [.purple,
                           .red,
                           .orange,
                           .yellow,
                           .green,
                           .blue]

    @State var selectedColor: Color?

    var body: some View {
        HStack {
            ForEach(colors, id:  \.description) { color in
                ColorCheckBox(selectedColor: self.$selectedColor, color: color)
            }
        }
        .padding()
    }
}
