import SwiftUI

struct ColorCheckBox: View {

    @Binding var selectedColor: Color?
    var color: Color

    var body: some View {
        Button(action: { self.selectedColor = self.color }) {
            Image(systemName: self.selectedColor == color ? "checkmark.square.fill" : "square.fill")
                .resizable()
                .frame(width: 20, height: 20)
        }
        .buttonStyle(.borderless)
        .tint(self.color)
    }
}
