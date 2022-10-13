import SwiftUI

/// TaskGroup sheet view.
struct TaskGroupSheet: View {
    @Environment(\.dismiss) var dismiss

    var group: TaskGroup?
    var listVM: TaskListVM

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
                    listVM.addOrUpdateTaskGroup(group: group, groupName)
                } onDelete: {
                    guard group != nil else { return }
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
