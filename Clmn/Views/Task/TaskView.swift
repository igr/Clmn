import SwiftUI

struct TaskView: View {
    @EnvironmentObject var dragTask: DragTaskModel

    var task: Task
    var editTaskAction: () -> Void
    var deleteTaskAction: () -> Void

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        HStack {
            HStack(alignment: .top) {
//                Image(systemName: checkboxName(task))
//                .font(Font.system(size: 16, design: .monospaced))
//                .foregroundColor(.gray)
//                .gesture(TapGesture().onEnded {
//                    let hasOption = NSEvent.modifierFlags.contains(.option)
//                    if (hasOption) {
//                        toggleProgress(task)
//                    } else {
//                        task.completed.toggle()
//                        if (task.completed == false) {
//                            task.inProgress = 0
//                        }
//                    }
//                })
//                .onHover { isHovered in CursorUtil.handOnHover(isHovered) }
//                .padding(.top, 2)

                Text((task.name).trimmingCharacters(in: .whitespacesAndNewlines).markdown())
                .strikethrough(task.completed)
                .gesture(TapGesture(count: 2).onEnded { editTaskAction() })

                Spacer()
            }
            .padding(2)
            .contentShape(Rectangle())
        }
        .contextMenu {
            Button(
                action: editTaskAction,
                label: {
                    Label("Edit Task", systemImage: Icons.squareAndPencil)
                    .labelStyle(.titleAndIcon)

                }
            )
            Button(
                action: deleteTaskAction,
                label: {
                    Label("Delete Task", systemImage: Icons.minusSquareFill)
                    .labelStyle(.titleAndIcon)

                }
            )
        }
        .onDrag { dragTask.startDragOf(task) }
//        .onDrop(of: [TASK_UTI], delegate: TaskDropOnTaskDelegate(source: dragTask.task, target: task))
    }
}
