import SwiftUI

/// Task sheet view.
struct TaskSheet: View {
    @Environment(\.dismiss) var dismiss

    var task: Task?
    var onSave: (_: String, _: Int) -> Void

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
                SheetCancelOk {
                    onSave(name, color)
                }
            }
            .padding()
        }
        .frame(width: 360, height: 300)
        .onAppear {
            name = task?.name ?? ""
            color = task?.color ?? 0
        }
    }
}

