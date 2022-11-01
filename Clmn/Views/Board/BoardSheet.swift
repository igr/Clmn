import SwiftUI

/// Simple board sheet view.
struct BoardSheet: View {
    @Environment(\.dismiss) var dismiss

    var board: Board?
    var allBoardsVM: AllBoardsVM

    @Binding var selectedBoard: Board?

    @State private var boardName: String = ""

    private func isUpdate() -> Bool {
        board != nil
    }

    var body: some View {
        VStack {
            SheetHeader("Board")
            VStack {
                FormTextField(
                    text: $boardName,
                    placeholder: "Board Title...",
                    imageName: Icons.board)
                Spacer()
                SheetCancelOk(isUpdate: isUpdate()) {
                    allBoardsVM.addOrUpdateBoard(board: board, name: boardName)
                    if (isUpdate()) {
                        // need to update the selected board as its content is updated :)
                        selectedBoard = allBoardsVM.findBoardById(board!.id)
                    } else {
                        selectedBoard = allBoardsVM.boards.last
                    }
                } onDelete: {
                    guard isUpdate() else { return }
                    let removedIndex = allBoardsVM.deleteBoard(board!)
                    selectedBoard = allBoardsVM.boards.safeGet(removedIndex)
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

