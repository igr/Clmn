import SwiftUI

class BoardsViewModel: ObservableObject {

    @Published private(set) var boards: [Board] = []

    func loadBoards() {
        boards = services.boardService.fetchBoards()
    }

    /// Creates a new board.
    func addNewBoard(_ name: String) {
        let newBoard = Board(name: name, order: boards.countNextOrder())
        boards.append(newBoard)
    }

    /// Deletes a board.
    func deleteBoard(_ boardToDelete: Board) {
        boards.removeElement(boardToDelete)
    }

    /// Updates the board.
    func updateBoard(_ boardToUpdate: Board, _ name: String) {
        boards.withElement(boardToUpdate) { i in
            boards[i].name = name
        }
    }
}
