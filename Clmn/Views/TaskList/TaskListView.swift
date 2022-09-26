import SwiftUI

struct TaskListView: View {
    var list: TaskList
    @ObservedObject var listsVM: TaskListsVM

//    @State private var taskDetails: Task?
//    @State private var taskGroupDetails: TaskGroup?

    @State private var taskListDetails: ModelOpt<TaskList>?
    @State private var hovered: Bool = false
    @EnvironmentObject var dragTaskList: DragTaskListModel

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        VStack(alignment: .leading) {
            if (hovered) {
                TaskListButton(list: list, taskListDetails: $taskListDetails)
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 20)
            }
            TaskListTitle(
                list: list
//                taskDetails: $taskDetails,
//                taskListDetails: $taskListDetails,
//                taskGroupDetails: $taskGroupDetails,
//                addTaskAction: addTask
            )
            .onDrag {
                dragTaskList.startDragOf(list)
            }
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(list.tasks, id: \.id) { task in
                        TaskView(
                            task: task
//                            editTaskAction: { taskDetails = task },
//                            deleteTaskAction: { deleteTask(task) }
                        )
                    }

//                    AddTaskLink(hovered: $hovered) { taskDetails = addTask() }

//                    let groups = list.allGroups()
//                    ForEach(groups, id: \.self) { group in
//                        GroupView(
//                            group: group,
//                            taskDetails: $taskDetails,
//                            taskGroupDetails: $taskGroupDetails,
//                            hovered: $hovered
//                        )
                }
            }
            .padding()
        }
        .sheet(item: $taskListDetails) { item in
            TaskListSheet(taskList: item.model) { title, description in
                listsVM.updateList(item.model!, title, description)
            }
        }

            //            .sheet(item: $taskDetails) { item in
//                TaskSheet(task: item)
//            }
//            .sheet(item: $taskGroupDetails) { item in
//                GroupSheet(taskGroup: item)
//            }
//        }
//        .background(Color.App.taskBackground)
//        .roundedCorners(2, corners: .allCorners)
        .onHover { hovered in
            self.hovered = hovered
        }

    }
}
