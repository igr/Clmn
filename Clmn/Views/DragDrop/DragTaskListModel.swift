import UniformTypeIdentifiers

let TASKLIST_UTI = UTType(APP_GROUP + ".list")!

class DragTaskListModel: ObservableObject {
    @Published var list: TaskList?

    func startDragOf(_ list: TaskList) -> NSItemProvider {
        self.list = list
        return NSItemProvider(item: list.title as NSString, typeIdentifier: TASKLIST_UTI.identifier)
    }

    func stopDrop() {
        list = nil
    }

}
