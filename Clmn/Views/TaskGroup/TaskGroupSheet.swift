import SwiftUI

/// TaskGroup sheet view.
struct TaskGroupSheet: View {
    @Environment(\.dismiss) var dismiss

    var group: TaskGroup?
    var listVM: TaskListVM

    @State private var groupName = ""

    private func isUpdate() -> Bool {
        group != nil
    }

    var body: some View {
        VStack {
            SheetHeader("Group")
            VStack {
                FormTextField(
                    text: $groupName,
                    placeholder: "Group Name...",
                    imageName: Icons.group)
                Spacer()
                SheetCancelOk(isUpdate: isUpdate()) {
                    listVM.addOrUpdateTaskGroup(group: group, groupName)
                } onDelete: {
                    guard isUpdate() else { return }
                    listVM.deleteTaskGroup(group!)
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
