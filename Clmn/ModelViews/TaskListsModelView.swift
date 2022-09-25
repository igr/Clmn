import SwiftUI

class TaskListsViewModel: ObservableObject {

    @Published private(set) var lists: [TaskList] = []

    func loadLists(board: Board) {
        lists = services.taskListsService.fetchTaskListsForBoard(board.id)
    }

}
