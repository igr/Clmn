import SwiftUI

class AllBoardsVM: ObservableObject {

    @Published private(set) var boards: [Board] = []

    func loadBoards() {
        boards = services.boards.fetchBoards()
    }

    func saveBoards() {
        services.boards.storeBoards(boards)
    }

    /// Creates a new board.
    private func addNewBoard(_ name: String) {
        let newBoard = Board(name: name)
        boards.append(newBoard)
        saveBoards()
    }

    /// Deletes a board.
    func deleteBoard(_ boardToDelete: Board) {
        boards.removeElement(boardToDelete)
        saveBoards()
    }

    /// Updates the board.
    private func updateBoard(_ boardToUpdate: Board, _ name: String) {
        boards.withElement(boardToUpdate) { i in
            boards[i].name = name
        }
    }

    /// Adds or updates the board.
    func addOrUpdateBoard(item: ModelOpt<Board>, boardName: String) {
        item.apply {
            addNewBoard(boardName)
        } or: { b in
            updateBoard(b, boardName)
        }
    }

    /// Reorders the boards.
    func reorder(from set: IndexSet, to destinationIndex: Int) {
        boards.move(fromOffsets: set, toOffset: destinationIndex)
        saveBoards()
    }
}
