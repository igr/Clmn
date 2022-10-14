import SwiftUI

/// Task sheet view.
struct TaskSheet: View {
    @Environment(\.dismiss) var dismiss

    var task: Task?
    var group: TaskGroup
    var listVM: TaskListVM

    @State private var name = ""
    @State private var note = ""
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
                    placeholder: "Task...",
                    imageName: Icons.task,
                    height: 46)
                FormTextEditor(
                    text: $note,
                    placeholder: "Note...",
                    imageName: Icons.formDescription)
                TaskColorRadioButtons(selectedColor: $color)
                Spacer()
                SheetCancelOk(isUpdate: isUpdate()) {
                    listVM.addOrUpdateTask(group: group, task: task, name: name, note: note, color: color)
                } onDelete: {
                    guard isUpdate() else { return }
                    listVM.deleteTask(task!)
                }
            }
            .padding()
        }
        .frame(width: 360, height: 380)
        .onAppear {
            name = task?.name ?? ""
            color = task?.color ?? 0
            note = task?.note ?? ""
        }
    }
}

