import Foundation

typealias TaskGroupId = UUID

struct TaskGroup: Identifiable, Equatable, Orderable, Codable {

    var id: TaskGroupId = TaskGroupId()
    var title: String
    var order: Int
    var tasks: [Task] = []

}
