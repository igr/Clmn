import SwiftUI

struct AddTaskButtons: View {

    @Binding var hovered: Bool
    var action: () -> Void
    var showAction2: Bool = false
    var action2: () -> Void = { }

    @State private var isHovering: Bool = false;

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if (hovered) {
                Spacer()

                Button(
                    action: action,
                    label: {
                        Image(systemName: Icons.addTask)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                    }
                )
                .buttonStyle(.borderless)
                .padding(.trailing)

                if (showAction2) {
                    Button(
                        action: action2,
                        label: {
                            Image(systemName: "plus.viewfinder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                        }
                    )
                    .buttonStyle(.borderless)
                    .padding(.trailing)
                }

                Spacer()
            }
            else {
                Spacer().frame(height: 14)
            }
        }
        .padding(.top, 10)
    }
}

struct AddTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskButtons(hovered: .constant(false), action: {})
    }
}
