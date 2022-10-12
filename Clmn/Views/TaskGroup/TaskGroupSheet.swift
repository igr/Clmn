import SwiftUI

/// TaskGroup sheet view.
struct TaskGroupSheet: View {
    @Environment(\.dismiss) var dismiss

    var group: TaskGroup?
    var onSave: (_: String) -> Void
    var onDelete: (_:TaskGroup) -> Void = {_ in }

    @State private var groupName = ""

    var body: some View {
        VStack {
            SheetHeader("Group")
            VStack {
                FormTextField(
                    text: $groupName,
                    placeholder: "Group Name...",
                    imageName: Icons.group)
                Spacer()
                SheetCancelOk(isUpdate: group != nil) {
                    onSave(groupName)
                } onDelete: {
                    guard group != nil else { return }
                    onDelete(group!)
                }
            }
            .padding()
        }
        .frame(width: goldenRatio.of(200), height: 200)
        .onAppear {
            groupName = group?.name ?? ""
        }
    }
}
