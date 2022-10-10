import SwiftUI

struct TaskView: View {
    @ObservedObject var listVM: TaskListVM
    var task: Task
    var editTaskAction: () -> Void
    var deleteTaskAction: () -> Void
    
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
//                .onHover { isHovered in CursorUtil.handOnHover(isHovered) }
                .padding(.top, 2)

                Text((task.name).trimmingCharacters(in: .whitespacesAndNewlines).markdown())
                .font(Font.App.taskText)
                .strikethrough(task.completed)
                .if(task.completed) { text in text.foregroundColor(Color.App.taskCompleted) }
                .gesture(TapGesture(count: 2).onEnded { editTaskAction() })
                Spacer()
                if (showEditButton) {
                    Menu {
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
                    } label: {
                        Image(systemName: Icons.ellipsis)
                    }
                    .menuStyle(.borderlessButton)
                    .menuIndicator(.hidden)
                    .fixedSize()
                    .padding(.top, 4)
                }
            }
            .padding(2)
            .contentShape(Rectangle())
            .onHover { isHovered in showEditButton = isHovered }
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
