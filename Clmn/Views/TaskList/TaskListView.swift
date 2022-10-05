import SwiftUI

struct TaskListView: View {
    @ObservedObject var allListsVM: AllTaskListsVM
    @StateObject var listVM: TaskListVM

    @State private var taskDetails: ModelOpt<Task>?
    @State private var taskGDetails: ModelPairOpt<Task, TaskGroup>?
    @State private var taskListDetails: ModelOpt<TaskList>?
    @State private var taskGroupDetails: ModelOpt<TaskGroup>?
    @State private var hovered: Bool = false
    @State private var deleteTask: DeleteIntent<Task> = DeleteIntent()
    @State private var deleteTaskG: DeleteIntent<(TaskGroup, Task)> = DeleteIntent()
    @State private var deleteTaskList: DeleteIntent<TaskList> = DeleteIntent()
    @State private var deleteTaskGroup: DeleteIntent<TaskGroup> = DeleteIntent()

    @EnvironmentObject var dragTaskList: DragTaskListModel

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        let list = listVM.list
        VStack(alignment: .leading) {
            if (hovered) {
                TaskListButton(
                    list: list,
                    taskListDetails: $taskListDetails,
                    taskDetails: $taskDetails,
                    taskGroupDetails: $taskGroupDetails,
                    deleteTaskList: $deleteTaskList)
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 20)
            }
            TaskListTitle(list: list)
            .onDrag {
                dragTaskList.startDragOf(list)
            }
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(list.tasks, id: \.id) { task in
                        TaskView(
                            task: task,
                            editTaskAction: { taskDetails = ModelOpt<Task>.of(task) },
                            deleteTaskAction: { deleteTask.set(task) }
                        )
                    }

//                    AddTaskLink(hovered: $hovered) { taskDetails = addTask() }

                    let groups = list.groups
                    ForEach(groups, id: \.id) { group in
                        TaskGroupView(
                            listVM: listVM,
                            group: group,
                            taskGroupDetails: $taskGroupDetails,
                            deleteTaskGroup: $deleteTaskGroup,
                            taskDetails: $taskGDetails,
                            deleteTask: $deleteTaskG,
                            hovered: $hovered
                        )
                    }
                }
            }
            .padding()
        }
        .deleteTaskConfirmation($deleteTask) { deletedTask in listVM.deleteTask(deletedTask) }
        .deleteTaskOfGroupConfirmation($deleteTaskG) { group, deletedTask in listVM.deleteTaskOfGroup(group, deletedTask) }
        .deleteTaskListConfirmation($deleteTaskList) { deletedTaskList in allListsVM.deleteList(deletedTaskList) }
        .deleteTaskGroupConfirmation($deleteTaskGroup) { deletedTaskGroup in listVM.deleteTaskGroup(deletedTaskGroup) }
        .sheet(item: $taskListDetails) { item in
            TaskListSheet(taskList: item.model) { title, description in
                allListsVM.updateList(item.model!, title, description)
            }
        }
        .sheet(item: $taskDetails) { item in
            TaskSheet(task: item.model) { taskName in
                listVM.addOrUpdateTask(item: item, taskName)
            }
        }
        .sheet(item: $taskGDetails) { item in
            TaskSheet(task: item.model) { taskName in
                listVM.addOrUpdateTaskOfGroup(item: item, taskName)
            }
        }
        .sheet(item: $taskGroupDetails) { item in
            TaskGroupSheet(taskGroup: item.model) { groupName in
                listVM.addOrUpdateTaskGroup(item: item, groupName)
            }
        }
        .background(Color.random)
//        .roundedCorners(2, corners: .allCorners)
        .onHover { hovered in
            self.hovered = hovered
        }
        .onAppear {
            /// IMPORTANT DETAIL
            // Since this view disappear _after_ parents view, we must
            // register tasklist providers now.
            allListsVM.register({
                listVM.list
            })
        }
    }
}
