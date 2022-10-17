import SwiftUI

struct TaskView: View {
    @ObservedObject var listVM: TaskListVM
    var task: Task
    var group: TaskGroup
    @Binding var taskDetails: ModelPairOpt<TaskGroup, Task>?
    @Binding var deleteTask: DeleteIntent<Task>
    @Binding var selectedTask: Task?

    @State private var hovered = false

    @Environment(\.colorScheme) var colorScheme
    @AppStorage(SETTINGS_TASK_CHECKBOX_IMAGE) private var taskCheckboxImage = false
    @AppStorage(SETTINGS_TASK_SELECTABLE) private var taskSelectable = true

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        VStack {
            HStack(alignment: .top) {
                Image(systemName: checkboxName(task))
                .font(Font.App.taskIcon)
                .gesture(TapGesture().onEnded {
                    let optionKeyPressed = NSEvent.modifierFlags.contains(.option)
                    let commandKeyPressed = NSEvent.modifierFlags.contains(.command)
                    if (commandKeyPressed) {
                        listVM.toggleProgress(task)
                    } else if (optionKeyPressed) {
                        listVM.toggleCancel(task)
                    }
                    else {
                        listVM.toggleCompleted(task)
                    }
                })
                .padding(.top, 2)
                .onHover { isHovered in CursorUtil.changeCursorOnHover(isHovered, cursor: NSCursor.pointingHand) }
                .foregroundColor(task.inactive() ? Color.App.taskCompleted : Color.App.listText)

                VStack {
                    HStack(alignment: .top) {
                        Text((task.name).trimmingCharacters(in: .whitespacesAndNewlines).markdown())
                        .font(Font.App.taskText)
                        .strikethrough(task.canceled())
                        .foregroundColor(task.inactive() ? Color.App.taskCompleted : Color.App.listText)

                        if (task.note != nil) {
                            Image(systemName: Icons.taskNote)
                            .foregroundColor(Color.App.listOffText)
                            .frame(width: 10, height: 10)
                            .padding(.top, 4)
                        }
                        Spacer()
                        if (selected() || hovered) {
                            Button(
                                action: { taskDetails = ModelPairOpt<TaskGroup, Task>.of(group, task) },
                                label: {
                                    Image(systemName: Icons.ellipsis)
                                    .frame(width: 18, height: 18)
                                    .contentShape(Rectangle())
                                }
                            )
                            .buttonStyle(.plain)
                        }
                    }
                    if (selected() && task.note != nil) {
                        HStack() {
                            Text(task.note?.markdown() ?? "")
                            .font(Font.App.taskNote)
                            .foregroundColor(Color.App.taskNote)
                            .padding(.bottom, 4)
                            Spacer()
                        }
                    }
                }
            }
            .padding(6)
            .onHover { isHovered in hovered = isHovered }
        }
        .if (selected() && taskSelectable) { view in
            view.colorScheme(colorScheme == .dark ? .light : .dark).background(Color.App.listSelect)
        }
        .background(taskColor(task))
        .roundedCorners(4, corners: .allCorners)
        .contentShape(Rectangle())
        .gesture(TapGesture().onEnded {
            select()
        })
        .padding(.bottom, 2)
        .contextMenu {
            Button {
                taskDetails = ModelPairOpt<TaskGroup, Task>.of(group, task)
            } label: {
                Label("Edit Task", systemImage: Icons.edit)
                    .labelStyle(.titleAndIcon)
            }
            Button(role: .destructive) {
                deleteTask.set(task)
            } label: {
                Label("Delete Task", systemImage: Icons.delete)
                    .labelStyle(.titleAndIcon)
            }
            Divider()
            Button {
                listVM.toggleCancel(task)
            } label: {
                Label((task.progress == -1) ? "Enable task" : "Cancel task", systemImage: Icons.cancelTask)
                .labelStyle(.titleAndIcon)
            }
            Button {
                listVM.toggleCompleted(task)
            } label: {
                Label((task.completed) ? "Reopen task" : "Complete task", systemImage: Icons.completeTask)
                .labelStyle(.titleAndIcon)
            }
            Divider()
            Button {
                let pasteboard = NSPasteboard.general
                pasteboard.declareTypes([.string], owner: nil)
                pasteboard.setString("\(APP_HOST)://tasks/\(task.id)", forType: .string)
            } label: {
                Label("Copy URL to clipboard", systemImage: Icons.taskLink)
                .labelStyle(.titleAndIcon)
            }
        }
    }

    private func checkboxName(_ task: Task) -> String {
        if (task.completed) {
            if (taskCheckboxImage) {
                return Icons.taskCompleted2
            } else {
                return Icons.taskCompleted
            }
        }
        switch task.progress {
        case -1: return Icons.taskCanceled
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

    /// Returns `true` if task is selected.
    private func selected() -> Bool {
        guard selectedTask != nil else { return false }
        return selectedTask!.id == task.id
    }

    private func select() {
        if (selectedTask == nil) {
            selectedTask = task
            return
        }
        if (selectedTask!.id == task.id) {
            selectedTask = nil
            return
        }
        selectedTask = task
    }

}
