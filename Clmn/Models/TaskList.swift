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

    func valid()  -> Bool {
        !groups.isEmpty
    }
}

extension Array where Element == TaskList {

    func with(_ list: TaskList, consumer: (Int) -> Void) {
        guard let index = firstIndex(where: { l in l.id == list.id } ) else { return }
        consumer(index)
    }
}
