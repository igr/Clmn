
public struct Services {
    let boardService: BoardService
    let taskListsService: TaskListService
}

// Static reference to all services.
let services = Services(
    boardService: BoardService(),
    taskListsService: TaskListService()
)
