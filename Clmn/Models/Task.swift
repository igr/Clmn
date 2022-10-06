import CoreData

typealias TaskId = UUID

struct Task: Identifiable, Equatable, Codable {

    var id: TaskId = TaskId()
    var name: String
    var completed: Bool = false
    var progress: Int = 0
    var created: Date = Date.now

    public static let foo = Task(id: TaskId(), name: "n/a")
}

extension Array where Element == Task {

    func with(_ task: Task, consumer: (Int) -> Void) {
        guard let index = firstIndex(where: { t in t.id == task.id } ) else { return }
        consumer(index)
    }

}
