import SwiftUI

struct TaskListTitle: View {
//    @EnvironmentObject var dragTask: DragTaskModel
//    @EnvironmentObject var dragTaskList: DragTaskListModel

    var list: TaskList
//    @Binding var taskDetails: Task?
//    @Binding var taskListDetails: TaskList?
//    @Binding var taskGroupDetails: TaskGroup?
//    @State private var isConfirmingTaskListDelete = false
//    var addTaskAction: () -> Task

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(list.title)
                .font(Font.App.listTitle)
                .gesture(TapGesture(count: 2).onEnded {
                    //taskListDetails = list
                })
            }
            .padding(.top, 10)
            Text((list.description ?? "").markdown())
        }
        .padding(.horizontal)
    }

}
