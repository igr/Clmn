import CoreData

struct Task : Identifiable, Equatable, Orderable {

    let id: UUID = UUID()
    var list: TaskList?
    var name: String
    var order: Int
    var completed: Bool = false
    var inProgress: Int = 0
    var created: Date = Date.now
    let tasks: [Task] = []

}
