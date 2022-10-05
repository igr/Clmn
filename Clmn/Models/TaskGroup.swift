import Foundation

typealias TaskGroupId = UUID

struct TaskGroup: Identifiable, Equatable, Codable {

    var id: TaskGroupId = TaskGroupId()
    var name: String
    var tasks: [Task] = []

}
