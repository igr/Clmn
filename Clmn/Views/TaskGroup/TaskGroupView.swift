import SwiftUI

struct TaskGroupView: View {
    var group: TaskGroup
    @Binding var taskGroupDetails: ModelOpt<TaskGroup>?
    @Binding var hovered: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(group.name)
                    .font(Font.App.groupName)
                Spacer()
                if (hovered) {
                    Button(
                        action: { taskGroupDetails = ModelOpt<TaskGroup>.of(group) },
                        label: {
                            Image(systemName: Icons.ellipsis)
                            .frame(width: 18, height: 18)
                            .contentShape(Rectangle())
                        }
                    )
                    .buttonStyle(.borderless)
                    .padding(.top, 4)
                    .padding(.trailing, 6)
                }
            }
            Divider().padding(.bottom, 6)
        }
    }
}
