import SwiftUI

struct TaskColorRadioButtons: View {
    @Binding var selectedColor: Int
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            FormLabel("Background:")
            ForEachWithIndex(Color.App.taskColors, id:  \.description) { index, color in
                ColorCheckBox(selectedColor: $selectedColor, color: (index, color))
                    .colorScheme(colorScheme == .dark ? .light : .dark)
            }
            Spacer()
        }
        .padding([.top,.bottom])
    }
}
