import CoreData

typealias TaskId = UUID

struct Task: Identifiable, Equatable, Orderable, Codable {

    var id: TaskId = TaskId()
    var name: String
    var order: Int
    var completed: Bool = false
    var inProgress: Int = 0
    var created: Date = Date.now

}
