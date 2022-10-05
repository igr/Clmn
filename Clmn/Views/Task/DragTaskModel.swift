import UniformTypeIdentifiers

let TASK_UTI = UTType(APP_GROUP + ".task")!

class DragTaskModel: ObservableObject {
    @Published var task: Task?

    func startDragOf(_ task: Task) -> NSItemProvider {
        self.task = task
        return NSItemProvider(item: task.name as NSString, typeIdentifier: TASK_UTI.identifier)
    }

}
