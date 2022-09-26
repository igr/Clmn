import SwiftUI

class TaskListsVM: ObservableObject {

    @Published private(set) var lists: [TaskList] = []

    private var board: Board = Board.foo

    func loadLists(board: Board) {
        lists = services.lists.fetchBoardLists(board.id)
        self.board = board
    }

    func saveLists() {
        services.lists.storeBoardLists(boardId: board.id, boardTaskList: lists)
    }

    func addNewList(_ title: String, _ description: String?) {
        let list = TaskList(boardId: board.id, title: title, order: lists.countNextOrder(), description: description)
        lists.append(list)
        services.lists.storeBoardListsAsync(boardId: board.id, boardTaskList: lists)
    }

    func updateList(_ list: TaskList, _ title: String, _ description: String?) {
        lists.withElement(list) { index in
            lists[index].title = title
            lists[index].description = description
        }
        services.lists.storeBoardListsAsync(boardId: board.id, boardTaskList: lists)
    }

    func addOrUpdate(item: ModelOpt<TaskList>, _ title: String, _ description: String?) {
        item.apply {
            addNewList(title, description)
        } or: { list in
            updateList(list, title, description)
        }
    }

    // ---------------------------------------------------------------- reorder

    func reorder(from: Int, to destinationIndex: Int) {
        reorder(from: [from], to: destinationIndex)
    }

    /// Reorders the lists.
    func reorder(from set: IndexSet, to destinationIndex: Int) {
        lists.move(fromOffsets: set, toOffset: destinationIndex)
        lists.reorder(setOrder: setListOrder)
        saveLists()
    }

    private func setListOrder(index: Int, newOrder: Int) {
        lists[index].order = newOrder
    }
}
