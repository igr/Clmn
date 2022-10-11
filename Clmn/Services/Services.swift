public struct Services {
    let app: AppService
    let boards: BoardsService
    let lists: TaskListsService
}

/// Static reference to all services.
let services = Services(
    app: AppService(),
    boards: BoardsService(),
    lists: TaskListsService()
)
