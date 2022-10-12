import SwiftUI

struct TaskListView: View {
    @ObservedObject var allListsVM: AllTaskListsVM
    @StateObject var listVM: TaskListVM

    @State private var taskDetails: ModelPairOpt<TaskGroup, Task>?
    @State private var taskListDetails: ModelOpt<TaskList>?
    @State private var taskGroupDetails: ModelOpt<TaskGroup>?

    @State private var hovered: Bool = false
    
    @State private var deleteTask: DeleteIntent<Task> = DeleteIntent()
    @State private var deleteTaskGroup: DeleteIntent<TaskGroup> = DeleteIntent()
    @State private var deleteTaskList: DeleteIntent<TaskList> = DeleteIntent()

    @EnvironmentObject var dragTask: DragTaskModel
    @EnvironmentObject var dragTaskList: DragTaskListModel
    @EnvironmentObject var dragTaskGroup: DragTaskGroupModel

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        let list = listVM.list
        VStack(alignment: .leading, spacing: 0) {
            TaskListButton(
                list: list,
                taskListDetails: $taskListDetails,
                hovered: $hovered
            )
            TaskListTitle(
                list: list,
                taskListDetails: $taskListDetails,
                taskGroupDetails: $taskGroupDetails,
                taskDetails: $taskDetails,
                deleteTaskList: $deleteTaskList
            )
            .onDrag {
                dragTaskList.startDragOf(list)
            }
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 0) {

                    let defaultGroup = list.defaultGroup()
                    let tasks = defaultGroup.tasks

                    ForEach(tasks, id: \.id) { task in
                        TaskView(
                            listVM: listVM,
                            task: task,
                            group: defaultGroup,
                            taskDetails: $taskDetails,
                            deleteTask: $deleteTask
                        )
                        .onDrag {
                            dragTask.startDragOf((list, defaultGroup, task), removeOnDrop: { task in listVM.deleteTask(task)})
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

                    AddTaskButtons(
                        hovered: $hovered,
                        action: { taskDetails = ModelPairOpt<TaskGroup, Task>.ofNew(defaultGroup) },
                        showAction2: list.groups.endIndex == 1,
                        action2: { taskGroupDetails = ModelOpt<TaskGroup>.ofNew() }
                    )

                    // ---------------------------------------------------------------- groups

                    if (!defaultGroup.tasks.isEmpty) {
                        Spacer().frame(height: 50)
                    }

                    let groups = list.appGroups()

                    ForEach(groups, id: \.id) { group in
                        TaskGroupView(
                            group: group,
                            taskGroupDetails: $taskGroupDetails,
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
                                appendTaskToGroup: { taskGroup, task in  listVM.addTask(toGroup: taskGroup, task: task) }
                            )
                        )

                        let tasks = group.tasks

                        ForEach(tasks, id: \.id) { task in
                            TaskView(
                                listVM: listVM,
                                task: task,
                                group: group,
                                taskDetails: $taskDetails,
                                deleteTask: $deleteTask
                            )
                            .onDrag {
                                dragTask.startDragOf((list, group, task), removeOnDrop: { task in listVM.deleteTask(task)})
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

                        AddTaskButtons(
                            hovered: $hovered,
                            action: { taskDetails = ModelPairOpt<TaskGroup, Task>.ofNew(group) },
                            showAction2: groups.isLast(group),
                            action2: { taskGroupDetails = ModelOpt<TaskGroup>.ofNew() }
                        )
                        if (!group.tasks.isEmpty) {
                            Spacer().frame(height: 50)
                        }
                    }
                }
            }
            .padding()
        }
        .sheet(item: $taskListDetails) { item in
            TaskListSheet(
                taskList: item.model,
                onSave: { title, description in
                    allListsVM.addOrUpdateList(item: item, title, description)
                    listVM.load(from: allListsVM.lists)
                },
                onDelete: { l in allListsVM.deleteList(l) }
            )
        }
        .sheet(item: $taskDetails) { item in
            TaskSheet(task: item.model) { taskName, taskColor in
                listVM.addOrUpdateTask(item: item, taskName, taskColor)
            } onDelete: { task in
                listVM.deleteTask(task)
            }
        }
        .sheet(item: $taskGroupDetails) { item in
            TaskGroupSheet(
                group: item.model,
                onSave: { groupName in listVM.addOrUpdateTaskGroup(item: item, groupName) },
                onDelete: { g in listVM.deleteTaskGroup(g) }
            )
        }
        .deleteTaskConfirmation($deleteTask) { deletedTask in listVM.deleteTask(deletedTask) }
        .deleteTaskGroupConfirmation($deleteTaskGroup) { deletedTaskGroup in listVM.deleteTaskGroup(deletedTaskGroup) }
        .deleteTaskListConfirmation($deleteTaskList) { deletedTaskList in allListsVM.deleteList(deletedTaskList) }        
        .background(Color.App.listBackground)
        .roundedCorners(2, corners: .allCorners)
        .onDrop(of: [TASK_UTI, TASKLIST_UTI],
            delegate: DropOnTaskListDispatcher(
                sourceTask: dragTask,
                sourceList: dragTaskList,
                target: list,
                reorderLists: allListsVM.reorder,
                appendTaskToList: { t in  listVM.addTaskToList(t) }
            )
        )
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
