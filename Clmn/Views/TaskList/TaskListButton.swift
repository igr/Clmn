import SwiftUI

struct TaskListButton: View {
    var list: TaskList
    @Binding var taskListDetails: ModelOpt<TaskList>?
    @Binding var taskDetails: ModelOpt<Task>?
    @Binding var taskGroupDetails: ModelOpt<TaskGroup>?
    @Binding var deleteTaskList: DeleteIntent<TaskList>

    var body: some View {
        HStack {
            Spacer()
            Menu {
                Button {
                    taskListDetails = ModelOpt<TaskList>.of(list)
                } label: {
                    Label("Edit List", systemImage: Icons.squareAndPencil)
                        .labelStyle(.titleAndIcon)
                }
                Button(role: .destructive) {
                    deleteTaskList.set(list)
                } label: {
                    Label("Delete List", systemImage: Icons.minusSquareFill)
                        .labelStyle(.titleAndIcon)
                }
                Divider()
                Button {

                } label: {
                    Label("Add List", systemImage: Icons.plusSquare)
                    .labelStyle(.titleAndIcon)
                }
                Divider()
                Button {
                    taskGroupDetails = ModelOpt<TaskGroup>.ofNew()
                } label: {
                    Label("Add Group", systemImage: Icons.plusCircle)
                    .labelStyle(.titleAndIcon)
                }
                Button {
                    taskDetails = ModelOpt<Task>.ofNew()
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
            Spacer()
        }

    }
}
