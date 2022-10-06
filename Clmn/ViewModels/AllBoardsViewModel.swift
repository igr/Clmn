import SwiftUI

class AllBoardsVM: ObservableObject {

    @Published private(set) var boards: [Board] = []

    func loadBoards() {
        boards = services.boards.fetchBoards()
    }

    func saveBoards() {
        services.boards.storeBoards(boards)
    }

    /// Returns `true` if no board is loaded
    func isEmpty() -> Bool {
        boards.isEmpty
    }

    /// Creates a new board.
    @discardableResult
    func addNewBoard(_ name: String) -> Board {
        let newBoard = Board(name: name)
        boards.append(newBoard)
        saveBoards()
        return newBoard
    }

    /// Deletes a board. Returns index of removed element.
    @discardableResult
    func deleteBoard(_ boardToDelete: Board) -> Int {
        let removedIndex = boards.removeElement(boardToDelete)
        saveBoards()
        return removedIndex
    }

    /// Updates the board.
    private func updateBoard(_ boardToUpdate: Board, _ name: String) {
        boards.with(boardToUpdate) { i in
            boards[i].name = name
        }
    }

    /// Adds or updates the board.
    func addOrUpdateBoard(item: ModelOpt<Board>, boardName: String) {
        item.new {
            addNewBoard(boardName)
        } existing: { b in
            updateBoard(b, boardName)
        }
    }

    /// Reorders the boards.
    func reorder(from set: IndexSet, to destinationIndex: Int) {
        boards.move(fromOffsets: set, toOffset: destinationIndex)
        saveBoards()
    }
}
