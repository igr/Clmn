import SwiftUI

struct TaskListButton: View {
    var list: TaskList
    @Binding var taskListDetails: ModelOpt<TaskList>?
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
                //            Button(role: .destructive) {
                //                isConfirmingTaskListDelete = true
                //            } label: {
                //                Label("Delete List", systemImage: Constants.Icons.minusSquareFill)
                //                    .labelStyle(.titleAndIcon)
                //            }
                //            Divider()
                //            Button {
                //                taskGroupDetails = addTaskGroup()
                //            } label: {
                //                Label("Add Group", systemImage: Constants.Icons.plusSquareOnSquare)
                //                    .labelStyle(.titleAndIcon)
                //            }
                //            Divider()
                //            Button {
                //                taskDetails = addTaskAction()
                //            } label: {
                //                Label("Add Task", systemImage: Constants.Icons.plus)
                //                    .labelStyle(.titleAndIcon)
                //            }
            } label: {
                Image(systemName: Icons.ellipsis)
            }
            .frame(maxWidth: 100)
            Spacer()
        }

    }
}
