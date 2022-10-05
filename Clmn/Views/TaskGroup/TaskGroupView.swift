import SwiftUI

struct TaskGroupView: View {
    @EnvironmentObject var dragTask: DragTaskModel
    @EnvironmentObject var dragTaskGroup: DragTaskGroupModel

    @ObservedObject var listVM: TaskListVM
    var group: TaskGroup
    @Binding var taskGroupDetails: ModelOpt<TaskGroup>?
    @Binding var deleteTaskGroup: DeleteIntent<TaskGroup>
    @Binding var taskDetails: ModelPairOpt<Task, TaskGroup>?
    @Binding var deleteTask: DeleteIntent<(TaskGroup, Task)>
    @Binding var hovered: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(group.name)
                Spacer()
                if (hovered) {
                    Menu {
                        Button {
                            taskGroupDetails = ModelOpt<TaskGroup>.of(group)
                        } label: {
                            Label("Edit Group", systemImage: Icons.squareAndPencil)
                            .labelStyle(.titleAndIcon)
                        }
                        Button(role: .destructive) {
                            deleteTaskGroup.set(group)
                        } label: {
                            Label("Delete Group", systemImage: Icons.minusSquareFill)
                            .labelStyle(.titleAndIcon)
                        }
                        Divider()
                        Button {
                            taskDetails = ModelPairOpt<Task, TaskGroup>.ofNew(group)
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
                    .padding(.top, 6)
                }
//                .onHover { isHovered in
//                    CursorUtil.handOnHover(isHovered)
//                }
            }
//            .padding(.top, 50)
            Divider()
        }
        .onDrag {
            dragTaskGroup.startDragOf(group)
        }
        .onDrop(of: [TASK_UTI, TASKGROUP_UTI],
            delegate: DropOnTaskGroupDispatcher(
                sourceTask: dragTask.task,
                sourceGroup: dragTaskGroup.group,
                target: group,
                reorderGroups: listVM.reorder
            )
        )

        let tasks = group.tasks
        ForEach(tasks, id: \.id) { task in
            TaskView(
                task: task,
                editTaskAction: { taskDetails = ModelPairOpt<Task, TaskGroup>.of(group, task) },
                deleteTaskAction: { deleteTask.set((group, task)) }
            )
        }
//        AddTaskLink(hovered: $hovered) { taskDetails = addTask(group) }
    }
}
