import SwiftUI
import UniformTypeIdentifiers

struct DropOnTaskGroupDispatcher: DropDelegate {
    var sourceTask: DragTaskModel?
    var sourceGroup: DragTaskGroupModel?
    var target: (TaskList, TaskGroup)

    var reorderGroups: (_: TaskGroup, _: TaskGroup) -> Void
    var appendTaskToGroup: (_: TaskGroup, _: Task) -> Void

    func performDrop(info: DropInfo) -> Bool {
        if (info.hasItemsConforming(to: [TASK_UTI])) {
            guard (sourceTask != nil) else { return false }
            return DragTaskDropOnTaskGroup(
                source: sourceTask!,
                target: target.1,
                append: appendTaskToGroup)
            .performDrop(info: info)
        }
        else if (info.hasItemsConforming(to: [TASKGROUP_UTI])) {
            guard (sourceGroup != nil) else { return false }
            return DragTaskGroupDropOnTaskGroup(
                source: sourceGroup!,
                target: target,
                reorder: reorderGroups)
            .performDrop(info: info)
        }
        return false
    }
}
