import SwiftUI

struct TaskGroupView: View {
    var group: TaskGroup
    @Binding var taskGroupDetails: ModelOpt<TaskGroup>?
    @Binding var taskDetails: ModelPairOpt<TaskGroup, Task>?
    @Binding var deleteTaskGroup: DeleteIntent<TaskGroup>
    @Binding var hovered: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(group.name)
                    .font(Font.App.groupName)
                Spacer()
                if (hovered) {
                    Menu {
                        Button {
                            taskGroupDetails = ModelOpt<TaskGroup>.of(group)
                        } label: {
                            Label("Edit Group", systemImage: Icons.squareAndPencil)
                            .labelStyle(.titleAndIcon)
                        }
                        Button(role: .destructive) {
                            deleteTaskGroup.set(group)
                        } label: {
                            Label("Delete Group", systemImage: Icons.minusSquareFill)
                            .labelStyle(.titleAndIcon)
                        }
                        Divider()
                        Button {
                            taskDetails = ModelPairOpt<TaskGroup, Task>.ofNew(group)
                        } label: {
                            Label("Add Task", systemImage: Icons.plus)
                            .labelStyle(.titleAndIcon)
                        }
                    } label: {
                        Image(systemName: Icons.ellipsis)
                    }
                    .menuStyle(.borderlessButton)
                    .menuIndicator(.hidden)
                    .fixedSize()
                    .padding(.top, 4)
                }
            }
            Divider()
        }
    }
}
