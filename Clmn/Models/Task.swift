import CoreData

typealias TaskId = UUID

struct Task: Identifiable, Equatable, Codable {

    var id: TaskId = TaskId()
    var name: String
    var color: Int = 0
    // meta
    var completed: Bool = false
    var progress: Int = 0
    var created: Date = Date.now
    var completedAt: Date? = nil

    public static let foo = Task(id: TaskId(), name: "n/a")
    
    func canceled() -> Bool {
        progress == -1
    }
    func inProgress() -> Bool {
        progress > 0
    }
    func inactive() -> Bool {
        completed || progress == -1
    }
}

extension Array where Element == Task {

    func with(_ task: Task, consumer: (Int) -> Void) {
        guard let index = firstIndex(where: { t in t.id == task.id } ) else { return }
        consumer(index)
    }

}
