import SwiftUI

struct AddTaskButton: View {

    @Binding var hovered: Bool
    var action: () -> Void

    @State private var isHovering: Bool = false;

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            if (hovered) {
                Button(
                    action: action,
                    label: {
                        Image(systemName: Icons.plus)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                    }
                )
                .buttonStyle(BorderlessButtonStyle())
            } else {
                Spacer()
                .frame(height: 14)
            }
            Spacer()
        }
        .padding(.top, 10)
    }
}

struct AddTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskButton(hovered: .constant(false), action: {})
    }
}
