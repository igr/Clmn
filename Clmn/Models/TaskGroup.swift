import Foundation

typealias TaskGroupId = UUID

struct TaskGroup: Identifiable, Equatable, Codable {

    var id: TaskGroupId = TaskGroupId()
    var name: String
    var tasks: [Task] = []

    public static let foo = TaskGroup(id: TaskGroupId(), name: "n/a")
}

extension Array where Element == TaskGroup {

    func with(_ task: Task, consumer: (Int, Int) -> Void) {
        for (groupIndex, group) in enumerated() {
            group.tasks.with(task) { taskIndex in
                consumer(groupIndex, taskIndex)
                return
            }
        }
    }

    func with(_ group: TaskGroup, consumer: (Int) -> Void) {
        guard let index = firstIndex(where: { g in g.id == group.id } ) else { return }
        consumer(index)
    }
}

