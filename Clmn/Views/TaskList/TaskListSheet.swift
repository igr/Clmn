import SwiftUI

struct TaskListSheet: View {
    @Environment(\.dismiss) var dismiss

    var taskList: TaskList?
    var onSave: (_: String, _: String) -> Void
    var onDelete: (_:TaskList) -> Void = {_ in }

    @State private var title = ""
    @State private var description = ""

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
                Spacer()
                SheetCancelOk(isUpdate: taskList != nil) {
                    onSave(title, description)
                } onDelete: {
                    guard taskList != nil else { return }
                    onDelete(taskList!)
                }
            }
            .padding()
        }
        .frame(width: 360, height: 300)
        .onAppear {
            title = taskList?.title ?? ""
            description = taskList?.description ?? ""
        }
    }
}
