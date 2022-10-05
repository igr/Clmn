import SwiftUI
import UniformTypeIdentifiers

struct DropOnTaskGroupDispatcher: DropDelegate {
    var sourceTask: Task?
    var sourceGroup: TaskGroup?
    var target: TaskGroup
    var reorderGroups: (_: TaskGroup, _: TaskGroup) -> Void

    func performDrop(info: DropInfo) -> Bool {
        if (info.hasItemsConforming(to: [TASK_UTI])) {
            //return TaskDropOnTaskGroupDelegate(source: sourceTask, target: target).performDrop(info: info)
        }
        else if (info.hasItemsConforming(to: [TASKGROUP_UTI])) {
            return DragTaskGroupDropOnTaskGroup(source: sourceGroup, target: target, reorder: reorderGroups).performDrop(info: info)
        }
        return false
    }
}
