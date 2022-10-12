import SwiftUI

struct TaskGroupView: View {
    var group: TaskGroup
    @Binding var taskGroupDetails: ModelOpt<TaskGroup>?
    @Binding var deleteTaskGroup: DeleteIntent<TaskGroup>
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
            .contextMenu {
                Button {
                    taskGroupDetails = ModelOpt<TaskGroup>.of(group)
                } label: {
                    Label("Edit Group", systemImage: Icons.edit)
                    .labelStyle(.titleAndIcon)
                }
                Button(role: .destructive) {
                    deleteTaskGroup.set(group)
                } label: {
                    Label("Delete Group", systemImage: Icons.delete)
                    .labelStyle(.titleAndIcon)
                }
                Divider()
                Button {
                    taskGroupDetails = ModelOpt<TaskGroup>.ofNew()
                } label: {
                    Label("Add Group", systemImage: Icons.addGroup)
                    .labelStyle(.titleAndIcon)
                }
                Button {
                    //taskDetails = ModelPairOpt<TaskGroup, Task>.ofNew(list.defaultGroup())
                } label: {
                    Label("Add Task", systemImage: Icons.addTask)
                    .labelStyle(.titleAndIcon)
                }
            }
            Divider().padding(.bottom, 6)
        }
    }
}
