import SwiftUI

struct DragTaskListDropOnTaskList: DropDelegate {
    var source: TaskList?
    var target: TaskList
    var reorder: (_: Int, _: Int) -> Void

    func performDrop(info: DropInfo) -> Bool {
        guard source != nil else {
            return false
        }
        guard info.hasItemsConforming(to: [TASKLIST_UTI]) else {
            return false
        }
        let from : TaskList = source!

        if (from.id == target.id) {
            return false
        }

        reorder(from.order, target.order)

        return true
    }
}
