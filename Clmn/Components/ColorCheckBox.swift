import SwiftUI

struct ColorCheckBox: View {

    @Binding var selectedColor: Int
    var color: (Int, Color)
    
    private func selected() -> Bool {
        self.selectedColor == color.0
    }

    var body: some View {
        Button(action: { self.selectedColor = self.color.0 }) {
            Image(systemName: selected() ? "checkmark.square.fill" : "square.fill")
                .resizable()
                .frame(width: 20, height: 20)
        }
        .buttonStyle(.borderless)
        .tint(self.color.1)
    }
}
