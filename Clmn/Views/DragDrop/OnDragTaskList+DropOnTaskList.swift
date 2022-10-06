import SwiftUI

/// TaskLists are only dragged within the same board.
/// They are simply reordered.
struct DragTaskListDropOnTaskList: DropDelegate {
    var source: DragTaskListModel
    var target: TaskList
    var reorder: (_: TaskList, _: TaskList) -> Void

    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: [TASKLIST_UTI]) else { return false }
        guard let origin = source.list else { return false }
        source.stopDrop()

        if (origin.id == target.id) {
            return false
        }

        reorder(origin, target)
        return true
    }
}
