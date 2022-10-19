import SwiftUI

struct TaskListTitle: View {
    var list: TaskList
    var allListsVM: AllTaskListsVM
    var listVM: TaskListVM

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
            .padding(.horizontal)
        }
        .contentShape(Rectangle())
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
            Menu {
                Button {
                    // TODO Improve this!
                    listVM.deleteCanceledTasks()
                    allListsVM.apply(from: listVM.list)
                } label: {
                    Label("Delete canceled tasks", systemImage: Icons.cancelTask)
                    .labelStyle(.titleAndIcon)
                }
                Button {
                    // TODO Improve this!
                    listVM.deleteCompletedTasks()
                    allListsVM.apply(from: listVM.list)
                } label: {
                    Label("Delete completed tasks", systemImage: Icons.completeTask)
                    .labelStyle(.titleAndIcon)
                }
            } label: {
                Label("List actions...", systemImage: Icons.taskActions)
                .labelStyle(.titleAndIcon)
            }
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
