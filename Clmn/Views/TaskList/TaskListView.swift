import SwiftUI

struct TaskListView: View {
    @ObservedObject var allListsVM: AllTaskListsVM
    @StateObject var listVM: TaskListVM

    @State private var taskDetails: ModelPairOpt<TaskGroup, Task>?
    @State private var taskListDetails: ModelOpt<TaskList>?
    @State private var taskGroupDetails: ModelOpt<TaskGroup>?

    @State private var deleteTask: DeleteIntent<Task> = DeleteIntent()
    @State private var deleteTaskList: DeleteIntent<TaskList> = DeleteIntent()
    @State private var deleteTaskGroup: DeleteIntent<TaskGroup> = DeleteIntent()

    @State private var hovered: Bool = false

    @EnvironmentObject var dragTask: DragTaskModel
    @EnvironmentObject var dragTaskList: DragTaskListModel
    @EnvironmentObject var dragTaskGroup: DragTaskGroupModel

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        let list = listVM.list
        VStack(alignment: .leading) {
            TaskListButton(
                list: list,
                taskListDetails: $taskListDetails,
                taskGroupDetails: $taskGroupDetails,
                taskDetails: $taskDetails,
                deleteTaskList: $deleteTaskList,
                hovered: $hovered
            )
            TaskListTitle(list: list)
            .onDrag {
                dragTaskList.startDragOf(list)
            }
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {

                    let defaultGroup = list.defaultGroup()
                    let tasks = defaultGroup.tasks

                    ForEach(tasks, id: \.id) { task in
                        TaskView(
                            listVM: listVM,
                            task: task,
                            editTaskAction: { taskDetails = ModelPairOpt<TaskGroup, Task>.of(defaultGroup, task) },
                            deleteTaskAction: { deleteTask.set(task) }
                        )
                        .onDrag {
                            dragTask.startDragOf((defaultGroup, task), removeOnDrop: { task in listVM.deleteTask(task)})
                        }
                        .onDrop(
                            of: [TASK_UTI],
                            delegate: DragTaskDropOnTask(
                                source: dragTask,
                                target: (defaultGroup, task),
                                appendToTarget: { t in listVM.insertTask(t, before: task) },
                                reorder: { s, d in listVM.reorder(group: defaultGroup, source: s, destination: d)}
                            )
                        )
                    }

                    AddTaskButton(hovered: $hovered) { taskDetails = ModelPairOpt<TaskGroup, Task>.ofNew(defaultGroup) }

                    // ---------------------------------------------------------------- groups

                    let groups = list.appGroups()
                    ForEach(groups, id: \.id) { group in
                        TaskGroupView(
                            group: group,
                            taskGroupDetails: $taskGroupDetails,
                            taskDetails: $taskDetails,
                            deleteTaskGroup: $deleteTaskGroup,
                            hovered: $hovered
                        )
                        .onDrag {
                            dragTaskGroup.startDragOf(list, group)
                        }
                        .onDrop(of: [TASK_UTI, TASKGROUP_UTI],
                            delegate: DropOnTaskGroupDispatcher(
                                sourceTask: dragTask,
                                sourceGroup: dragTaskGroup,
                                target: (list, group),
                                reorderGroups: listVM.reorder,
                                appendTaskToGroup: { taskGroup, task in
                                    listVM.addTask(toGroup: taskGroup, task: task)
                                }
                            )
                        )

                        let tasks = group.tasks

                        ForEach(tasks, id: \.id) { task in
                            TaskView(
                                listVM: listVM,
                                task: task,
                                editTaskAction: { taskDetails = ModelPairOpt<TaskGroup, Task>.of(group, task) },
                                deleteTaskAction: { deleteTask.set(task) }
                            )
                            .onDrag {
                                dragTask.startDragOf((group, task), removeOnDrop: { task in listVM.deleteTask(task)})
                            }
                            .onDrop(
                                of: [TASK_UTI],
                                delegate: DragTaskDropOnTask(
                                    source: dragTask,
                                    target: (group, task),
                                    appendToTarget: { t in listVM.insertTask(t, before: task) },
                                    reorder: { s, d in listVM.reorder(group: group, source: s, destination: d)}
                                )
                            )
                        }

                        AddTaskButton(hovered: $hovered) { taskDetails = ModelPairOpt<TaskGroup, Task>.ofNew(group) }
                    }
                }
            }
            .padding()
        }
        .deleteTaskConfirmation($deleteTask) { deletedTask in listVM.deleteTask(deletedTask) }
        .deleteTaskListConfirmation($deleteTaskList) { deletedTaskList in allListsVM.deleteList(deletedTaskList) }
        .deleteTaskGroupConfirmation($deleteTaskGroup) { deletedTaskGroup in listVM.deleteTaskGroup(deletedTaskGroup) }
        .sheet(item: $taskListDetails) { item in
            TaskListSheet(taskList: item.model) { title, description in
                allListsVM.addOrUpdateList(item: item, title, description)
                listVM.load(from: allListsVM.lists)
            }
        }
        .sheet(item: $taskDetails) { item in
            TaskSheet(task: item.model) { taskName in
                listVM.addOrUpdateTask(item: item, taskName)
            }
        }
        .sheet(item: $taskGroupDetails) { item in
            TaskGroupSheet(taskGroup: item.model) { groupName in
                listVM.addOrUpdateTaskGroup(item: item, groupName)
            }
        }
        .background(Color.App.listBackground)
        .roundedCorners(2, corners: .allCorners)
        .onHover { hovered in
            self.hovered = hovered
        }
        .onAppear {
            /// IMPORTANT DETAIL
            // Since this view dissappear _after_ the parent view, we must
            // register tasklist providers now, so they become availiable
            // when parent dissappear.
            allListsVM.register({ listVM.list })
        }
    }
}
