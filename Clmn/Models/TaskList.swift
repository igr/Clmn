import CoreData

typealias TaskListId = UUID

struct TaskList: Identifiable, Equatable, Codable {

    var id: TaskListId = TaskListId()
    var boardId: BoardId
    var title: String
    var description: String?

    var groups: [TaskGroup] = [TaskGroup(id: TaskGroupId(), name: "*")]

    public static let foo = TaskList(boardId: BoardId(), title: "n/a")

    func appGroups() -> ArraySlice<TaskGroup> {
        groups[1 ..< groups.endIndex]
    }

    func defaultGroup() -> TaskGroup {
        groups[0]
    }

    func valid() -> Bool {
        !groups.isEmpty
    }

    /// Calculates total tasks.
    func totalTasks() -> Int {
        groups.reduce(0) { $0 + $1.tasks.count }
    }

    func completedTasks() -> Int {
        groups.reduce(0) { $0 + $1.tasks.filter{$0.completed}.count }
    }

    func progress() -> Float {
        Float(completedTasks()) / Float(totalTasks())
    }
}

extension Array where Element == TaskList {

    func with(_ list: TaskList, consumer: (Int) -> Void) {
        guard let index = firstIndex(where: { l in l.id == list.id } ) else { return }
        consumer(index)
    }

    /// Returns `true` if the list is the last one.
    func isLast(_ list: TaskList) -> Bool {
        last?.id == list.id
    }
}
