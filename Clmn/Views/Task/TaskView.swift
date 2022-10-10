import SwiftUI

struct TaskView: View {
    @ObservedObject var listVM: TaskListVM
    var task: Task
    var editTaskAction: () -> Void

    @State private var showEditButton = false

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        HStack {
            HStack(alignment: .top) {
                Image(systemName: checkboxName(task))
                .font(Font.App.taskIcon)
                .gesture(TapGesture().onEnded {
                    let optionKeyPressed = NSEvent.modifierFlags.contains(.option)
                    if (optionKeyPressed) {
                        listVM.toggleProgress(task)
                    } else {
                        listVM.toggleCompleted(task)
                    }
                })
                .padding(.top, 2)
                .onHover { isHovered in CursorUtil.changeCursorOnHover(isHovered, cursor: NSCursor.pointingHand) }

                Text((task.name).trimmingCharacters(in: .whitespacesAndNewlines).markdown())
                .font(Font.App.taskText)
                .strikethrough(task.completed)
                .if(task.completed) { text in text.foregroundColor(Color.App.taskCompleted) }
//                .gesture(TapGesture(count: 2).onEnded { editTaskAction() })

                Spacer()

                if (showEditButton) {
                    Button(
                        action: editTaskAction,
                        label: {
                            Image(systemName: Icons.ellipsis)
                            .frame(width: 18, height: 18)
                            .contentShape(Rectangle())
                        }
                    )
                    .buttonStyle(.plain)
                }
            }
            .padding(6)
            .onHover { isHovered in showEditButton = isHovered }
        }
        .background(taskColor(task))
        .roundedCorners(4, corners: .allCorners)
        .contentShape(Rectangle())
        .padding(.bottom, 2)
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

    private func taskColor(_ task: Task) -> Color {
        if (task.color == 0) {
            return Color.App.listBackground
        }
        return Color.App.taskColors[task.color]
    }

}
