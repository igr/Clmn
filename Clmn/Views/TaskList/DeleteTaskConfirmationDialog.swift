import SwiftUI

struct DeleteTaskConfirmationDialog: ViewModifier {
    @Binding var deleteIntent: DeleteIntent<Task>

    var onCommit: (Task) -> Void

    func body(content: Content) -> some View {
        content
        .confirmationDialog("Are you sure?", isPresented: $deleteIntent.isPresented) {
            Button("Delete Task?", role: .destructive) {
                guard (deleteIntent.target != nil) else { return }
                onCommit(deleteIntent.target!)
                deleteIntent.reset()
            }
        }
    }
}

struct DeleteTaskOfGroupConfirmationDialog: ViewModifier {
    @Binding var deleteIntent: DeleteIntent<(TaskGroup, Task)>

    var onCommit: ((TaskGroup, Task)) -> Void

    func body(content: Content) -> some View {
        content
        .confirmationDialog("Are you sure?", isPresented: $deleteIntent.isPresented) {
            Button("Delete Task?", role: .destructive) {
                guard (deleteIntent.target != nil) else { return }
                onCommit(deleteIntent.target!)
                deleteIntent.reset()
            }
        }
    }
}


extension View {
    func deleteTaskConfirmation(_ deleteIntent: Binding<DeleteIntent<Task>>, onCommit: @escaping (Task) -> Void) -> some View {
        self.modifier(DeleteTaskConfirmationDialog(deleteIntent: deleteIntent, onCommit: onCommit))
    }
    func deleteTaskOfGroupConfirmation(_ deleteIntent: Binding<DeleteIntent<(TaskGroup, Task)>>, onCommit: @escaping ((TaskGroup, Task)) -> Void) -> some View {
        self.modifier(DeleteTaskOfGroupConfirmationDialog(deleteIntent: deleteIntent, onCommit: onCommit))
    }
}
