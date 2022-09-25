import CoreData

struct TaskList : Identifiable, Equatable, Orderable {

    let id: UUID = UUID()
    var board: Board
    var title: String
    var order: Int
    var desc: String?

}
