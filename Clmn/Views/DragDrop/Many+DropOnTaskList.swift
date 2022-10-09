import SwiftUI
import UniformTypeIdentifiers

struct DropOnTaskListDispatcher: DropDelegate {
    var sourceTask: DragTaskModel?
    var sourceList: DragTaskListModel?
    var target: TaskList

    var reorderLists: (_: TaskList, _: TaskList) -> Void
    var appendTaskToList: (_: Task) -> Void

    func performDrop(info: DropInfo) -> Bool {
        if (info.hasItemsConforming(to: [TASK_UTI])) {
            guard (sourceTask != nil) else { return false }
            return DragTaskDropOnTaskList(
                source: sourceTask!,
                target: target,
                append: appendTaskToList)
            .performDrop(info: info)
        }
        else if (info.hasItemsConforming(to: [TASKLIST_UTI])) {
            guard (sourceList != nil) else { return false }
            return DragTaskListDropOnTaskList(
                source: sourceList!,
                target: target,
                reorder: reorderLists)
            .performDrop(info: info)
        }
        return false
    }
}
