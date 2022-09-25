import SwiftUI

/// Simple board sheet view.
struct BoardSheet: View {
    @Environment(\.dismiss) var dismiss

    // existing board
    var board: Board?
    var onSave: (_: String) -> Void
    @State private var boardName: String = ""

    var body: some View {
        Text("BoardSheet")
        VStack {
            SheetHeader("Board")
            Form {
                TextField("", text: $boardName)

                Spacer()

                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                })
                .keyboardShortcut(.cancelAction)
                Button(action: {
                    onSave(boardName)
                    dismiss()
                }, label: {
                    Text("OK")
                })
                .keyboardShortcut(.defaultAction)
            }
            .padding()
        }
        .frame(width: 360, height: 200)
        .onAppear {
            boardName = board?.name ?? "New Board"
        }
    }
}

