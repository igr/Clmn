import SwiftUI

struct TaskListSheet: View {
    @Environment(\.dismiss) var dismiss

    var taskList: TaskList?
    var onSave: (_: String, _: String) -> Void
    var onDelete: (_:TaskList) -> Void = {_ in }

    @State private var title = ""
    @State private var description = ""
    
    private func existing() -> Bool {
        taskList != nil
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
                if (existing()) {
                    Text("Completed **\(taskList!.completedTasks())** of **\(taskList!.totalTasks())** tasks".markdown())
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
                SheetCancelOk(isUpdate: existing()) {
                    onSave(title, description)
                } onDelete: {
                    guard existing() else { return }
                    onDelete(taskList!)
                }
            }
            .padding()
        }
        .frame(width: 360, height: 400)
        .onAppear {
            title = taskList?.title ?? ""
            description = taskList?.description ?? ""
        }
    }
}
