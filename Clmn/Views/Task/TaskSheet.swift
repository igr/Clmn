import SwiftUI

/// Task sheet view.
struct TaskSheet: View {
    @Environment(\.dismiss) var dismiss

    var task: Task?
    var onSave: (_: String) -> Void

    @State private var name = ""

    var body: some View {
        VStack {
            SheetHeader("Task")
            Form {
                Spacer()
                TextEditor(text: $name)
                Spacer()
                SheetCancelOk {
                    onSave(name)
                }
            }
            .padding()
        }
        .frame(width: 360, height: 250)
        .onAppear {
            name = task?.name ?? ""
        }
    }
}

