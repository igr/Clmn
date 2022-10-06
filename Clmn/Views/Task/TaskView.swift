import SwiftUI

struct TaskView: View {
    @ObservedObject var listVM: TaskListVM
    var task: Task
    var editTaskAction: () -> Void
    var deleteTaskAction: () -> Void

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        HStack {
            HStack(alignment: .top) {
                Image(systemName: checkboxName(task))
                    .font(Font.App.taskIcon)
//                .foregroundColor(.gray)
                .gesture(TapGesture().onEnded {
                    let optionKeyPressed = NSEvent.modifierFlags.contains(.option)
                    if (optionKeyPressed) {
                        listVM.toggleProgress(task)
                    } else {
//                        task.completed.toggle()
//                        if (task.completed == false) {
//                            task.inProgress = 0
//                        }
                    }
                })
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
    }


    private func checkboxName(_ task: Task) -> String {
        if (task.completed) {
            return Icons.taskCompleted
        }
        switch task.progress {
        case 1: return Icons.taskProgress1
        case 2: return Icons.taskProgress2
        default:
            return Icons.taskOpen
        }
    }
}
