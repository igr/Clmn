import SwiftUI

struct TaskListSheet: View {
    @Environment(\.dismiss) var dismiss

    var list: TaskList?
    var allListsVM: AllTaskListsVM

    var onSave: () -> Void = {}

    @State private var title = ""
    @State private var description = ""

    private func isUpdate() -> Bool {
        list != nil
    }

    var body: some View {
        VStack {
            SheetHeader("List")
            VStack {
                FormTextField(
                    text: $title,
                    placeholder: "List Title...",
                    imageName: Icons.list)
                FormTextEditor(
                    text: $description,
                    placeholder: "Description",
                    imageName: Icons.formDescription
                )
                if (isUpdate()) {
                    Text("Completed **\(list!.completedTasks())** of **\(list!.totalTasks())** tasks".markdown())
                    .padding()
//                    HStack {
//                        Button {
//
//                        } label: {
//                            Text("Delete completed tasks")
//                        }
//                    }
                }
                Spacer()
                Divider()
                SheetCancelOk(isUpdate: isUpdate()) {
                    allListsVM.addOrUpdateList(list: list, title, description)
                    onSave()
                } onDelete: {
                    guard isUpdate() else { return }
                    allListsVM.deleteList(list!)
                }
            }
            .padding()
        }
        .frame(width: 360, height: 400)
        .onAppear {
            title = list?.title ?? ""
            description = list?.description ?? ""
        }
    }
}
