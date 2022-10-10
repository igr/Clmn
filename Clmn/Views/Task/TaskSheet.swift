import SwiftUI

/// Task sheet view.
struct TaskSheet: View {
    @Environment(\.dismiss) var dismiss

    var task: Task?
    var onSave: (_: String) -> Void

    @State private var name = ""
    @State private var selected = 1

    var body: some View {
        VStack {
            SheetHeader("Task")
            VStack {
                FormTextEditor(
                    text: $name,
                    placeholder: "Task",
                    imageName: Icons.task)
                TaskColorRadioButtons()
                Spacer()
                SheetCancelOk {
                    onSave(name)
                }
            }
            .padding()
        }
        .frame(width: 360, height: 300)
        .onAppear {
            name = task?.name ?? ""
        }
    }
}

