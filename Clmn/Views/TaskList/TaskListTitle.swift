import SwiftUI

struct TaskListTitle: View {
    var list: TaskList

    @Binding var taskListDetails: ModelOpt<TaskList>?
    @Binding var taskGroupDetails: ModelOpt<TaskGroup>?
    @Binding var taskDetails: ModelPairOpt<TaskGroup, Task>?
    @Binding var deleteTaskList: DeleteIntent<TaskList>
    @Binding var hovered: Bool
    var isLast: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TaskListButton(
                list: list,
                taskListDetails: $taskListDetails,
                hovered: $hovered,
                isLast: isLast
            )
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .top) {
                    Text(list.title)
                        .font(Font.App.listTitle)
                    Spacer()
                }
                .padding(.top, 10)
                Text((list.description ?? "").markdown())
                    .font(Font.App.listSubtitle)
                    .foregroundColor(Color.App.listSubtitle)
            }
        }
        .contentShape(Rectangle())
        .padding(.horizontal)
        .padding(.bottom, 4)
        .contextMenu {
            Button {
                taskListDetails = ModelOpt<TaskList>.of(list)
            } label: {
                Label("Edit List", systemImage: Icons.edit)
                .labelStyle(.titleAndIcon)
            }
            Button(role: .destructive) {
                deleteTaskList.set(list)
            } label: {
                Label("Delete List", systemImage: Icons.delete)
                .labelStyle(.titleAndIcon)
            }
            Divider()
            Button {
                taskListDetails = ModelOpt<TaskList>.ofNew()
            } label: {
                Label("Add List", systemImage: Icons.addList)
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
                taskDetails = ModelPairOpt<TaskGroup, Task>.ofNew(list.defaultGroup())
            } label: {
                Label("Add Task", systemImage: Icons.addTask)
                .labelStyle(.titleAndIcon)
            }
        }
    }

}
