import SwiftUI

/// TaskGroup sheet view.
struct TaskGroupSheet: View {
    @Environment(\.dismiss) var dismiss

    var taskGroup: TaskGroup?
    var onSave: (_: String) -> Void

    @State private var groupName = ""

    var body: some View {
        VStack {
            SheetHeader("Group")
            Form {
                FormLabel("Group name:")
                TextField("", text: $groupName)
                Spacer()
                SheetCancelOk {
                    onSave(groupName)
                }
            }
            .padding()
        }
        .frame(width: 360, height: 200)
        .onAppear {
            groupName = taskGroup?.name ?? ""
        }
    }
}
