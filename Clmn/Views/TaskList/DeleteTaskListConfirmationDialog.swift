import SwiftUI

struct DeleteTaskListConfirmationDialog: ViewModifier {
    @Binding var deleteIntent: DeleteIntent<TaskList>

    var onCommit: (TaskList) -> Void

    func body(content: Content) -> some View {
        content
        .confirmationDialog("Are you sure?", isPresented: $deleteIntent.isPresented) {
            Button("Delete List?", role: .destructive) {
                guard (deleteIntent.target != nil) else { return }
                onCommit(deleteIntent.target!)
                deleteIntent.reset()
            }
        }
    }
}

extension View {
    func deleteTaskListConfirmation(_ deleteIntent: Binding<DeleteIntent<TaskList>>, onCommit: @escaping (TaskList) -> Void) -> some View {
        self.modifier(DeleteTaskListConfirmationDialog(deleteIntent: deleteIntent, onCommit: onCommit))
    }
}
