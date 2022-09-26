public struct Services {
    let boards: BoardsService
    let lists: TaskListsService
}

/// Static reference to all services.
let services = Services(
    boards: BoardsService(),
    lists: TaskListsService()
)
