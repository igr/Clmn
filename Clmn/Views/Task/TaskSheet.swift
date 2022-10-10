import SwiftUI

/// Task sheet view.
struct TaskSheet: View {
    @Environment(\.dismiss) var dismiss

    var task: Task?
    var onSave: (_: String, _: Int) -> Void
    var onDelete: (_:Task) -> Void = {_ in }

    @State private var name = ""
    @State private var color = 0

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
                SheetCancelOk(isUpdate: task != nil) {
                    onSave(name, color)
                } onDelete: {
                    guard task != nil else { return }
                    onDelete(task!)
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

