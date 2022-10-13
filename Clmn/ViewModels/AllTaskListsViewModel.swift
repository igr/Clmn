import SwiftUI

typealias TaskListProvider = ()->TaskList

class AllTaskListsVM: ObservableObject {
    @Published private(set) var lists: [TaskList] = []

    private var board: Board = Board.foo

    func loadLists(board: Board) {
        lists = services.lists.fetchBoardLists(board.id)
        self.board = board
        queue.clear()
    }

    func saveLists() {
        services.lists.storeBoardLists(boardId: board.id, boardTaskList: lists)
    }

    @discardableResult
    func addNewList(_ title: String, description: String? = nil) -> TaskList {
        let list = TaskList(boardId: board.id, title: title, description: description)
        lists.append(list)
        saveLists()
        return list
    }

    func deleteList(_ list: TaskList) {
        lists.removeElement(list)
        saveLists()
    }

    func updateList(_ list: TaskList, _ title: String, _ description: String?) {
        lists.with(list) { index in
            lists[index].title = title
            lists[index].description = description
        }
        saveLists()
    }

    func addOrUpdateList(list: TaskList?, _ title: String, _ description: String?) {
        if (list == nil) {
            addNewList(title, description: description)
        } else {
            updateList(list!, title, description)
        }
    }

    // ---------------------------------------------------------------- reorder

    func reorder(from: TaskList, to destination: TaskList) {
        let fromIndex = lists.firstIndex(of: from)
        let toIndex = lists.firstIndex(of: destination)
        guard (fromIndex != nil && toIndex != nil) else { return }
        reorder(from: [fromIndex!], to: toIndex!)
    }

    /// Reorders the lists.
    func reorder(from set: IndexSet, to destinationIndex: Int) {
        lists.move(fromOffsets: set, toOffset: destinationIndex)
        saveLists()
    }

    // ---------------------------------------------------------------- child VMs

    private var queue: Queue<TaskListProvider> = Queue()

    /// Registers tasklist provider that will queued and used later.
    func register(_ taskListProvider: @escaping TaskListProvider) {
        queue.push(taskListProvider)
    }

    /// Handle queued list changes. If there are changes, invoke the commit
    /// lambda function.
    func handleListChanges(commit: ()->Void) {
        if (queue.size == 0) {
            return
        }
        while true {
            let tlp = queue.pop()
            if tlp == nil {
                break
            }
            let listToReplace = tlp!()
            apply(from: listToReplace)
        }
        commit()
    }

    func apply(from list: TaskList) {
        let ndx = lists.firstIndex(where: {tl in tl.id == list.id})
        guard (ndx != nil) else { return }
        lists[ndx!] = list
    }
}
