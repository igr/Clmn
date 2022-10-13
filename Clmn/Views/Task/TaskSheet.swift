import SwiftUI

/// Task sheet view.
struct TaskSheet: View {
    @Environment(\.dismiss) var dismiss

    var task: Task?
    var group: TaskGroup
    var listVM: TaskListVM

    @State private var name = ""
    @State private var color = 0

    private func isUpdate() -> Bool {
        task != nil
    }

    var body: some View {
        VStack {
            SheetHeader("Task")
            VStack {
                FormTextEditor(
                    text: $name,
                    placeholder: "Task",
                    imageName: Icons.task)
                TaskColorRadioButtons(selectedColor: $color)
                Spacer()
                SheetCancelOk(isUpdate: isUpdate()) {
                    listVM.addOrUpdateTask(group: group, task: task, name, color)
                } onDelete: {
                    guard isUpdate() else { return }
                    listVM.deleteTask(task!)
                }
            }
            .padding()
        }
        .frame(width: 360, height: 320)
        .onAppear {
            name = task?.name ?? ""
            color = task?.color ?? 0
        }
    }
}

