import SwiftUI

struct DeleteTaskGroupConfirmationDialog: ViewModifier {
    @Binding var deleteIntent: DeleteIntent<TaskGroup>

    var onCommit: (TaskGroup) -> Void

    func body(content: Content) -> some View {
        content
        .confirmationDialog("Are you sure?", isPresented: $deleteIntent.isPresented) {
            Button("Delete Group?", role: .destructive) {
                guard (deleteIntent.target != nil) else { return }
                onCommit(deleteIntent.target!)
                deleteIntent.reset()
            }
        }
    }
}

extension View {
    func deleteTaskGroupConfirmation(_ deleteIntent: Binding<DeleteIntent<TaskGroup>>, onCommit: @escaping (TaskGroup) -> Void) -> some View {
        self.modifier(DeleteTaskGroupConfirmationDialog(deleteIntent: deleteIntent, onCommit: onCommit))
    }
}
