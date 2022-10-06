import SwiftUI

/// Simple board sheet view.
struct BoardSheet: View {
    @Environment(\.dismiss) var dismiss

    var board: Board?
    var onSave: (_: String) -> Void

    @State private var boardName: String = ""

    var body: some View {
        VStack {
            SheetHeader("Board")
            VStack {
                FormTextField(
                    text: $boardName,
                    placeholder: "Board Title...",
                    imageName: Icons.board)
                Spacer()
                SheetCancelOk {
                    onSave(boardName)
                }
            }
            .padding()
        }
        .frame(width: goldenRatio.of(200), height: 200)
        .onAppear {
            boardName = board?.name ?? ""
        }
    }
}

