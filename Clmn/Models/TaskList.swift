import CoreData

typealias TaskListId = UUID

struct TaskList: Identifiable, Equatable, Orderable, Codable {

    var id: TaskListId = TaskListId()
    var boardId: BoardId
    var title: String
    var order: Int
    var description: String?

    var tasks: [Task] = []
    var groups: [TaskGroup] = []

    public static let foo = TaskList(boardId: BoardId.init(), title: "n/a", order: -1)

}
