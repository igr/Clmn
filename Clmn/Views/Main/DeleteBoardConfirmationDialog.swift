import SwiftUI

struct DeleteBoardConfirmationDialog: ViewModifier {
    @Binding var deleteIntent: DeleteIntent<Board>

    var onCommit: (Board) -> Void

    func body(content: Content) -> some View {
        content
        .confirmationDialog("Delete Board \n\(deleteIntent.target?.name ?? "")?", isPresented: $deleteIntent.isPresented) {
            Button("Yes", role: .destructive) {
                guard (deleteIntent.target != nil) else { return }
                onCommit(deleteIntent.target!)
                deleteIntent.reset()
            }
        }
    }
}

extension View {
    func deleteBoardConfirmation(_ deleteIntent: Binding<DeleteIntent<Board>>, onCommit: @escaping (Board) -> Void) -> some View {
        self.modifier(DeleteBoardConfirmationDialog(deleteIntent: deleteIntent, onCommit: onCommit))
    }
}
