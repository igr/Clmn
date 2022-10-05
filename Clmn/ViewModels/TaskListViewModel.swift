import SwiftUI

class TaskListVM: ObservableObject {
    @Published private(set) var list: TaskList

    init(_ list: TaskList) {
        self.list = list
    }

    private func addNewTask(_ name: String) {
        list.tasks.append(Task(name: name))
    }

    private func updateTask(_ task: Task, _ name: String) {
        list.tasks.withElement(task) { index in
            list.tasks[index].name = name
        }
    }

    func addOrUpdateTask(item: ModelOpt<Task>, _ name: String) {
        item.apply {
            addNewTask(name)
        } or: { task in
            updateTask(task, name)
        }
    }

    func deleteTask(_ task: Task) {
        list.tasks.removeElement(task)
    }


    // ---------------------------------------------------------------- tasks of groups

    private func addNewTaskToGroup(_ group: TaskGroup, _ name: String) {
        list.groups.withElement(group) { i in
            list.groups[i].tasks.append(Task(name: name))
        }
    }

    private func updateTaskOfGroup(_ group: TaskGroup,_ task: Task, _ name: String) {
        list.groups.withElement(group) { i in
            list.groups[i].tasks.withElement(task) { index in
                list.groups[i].tasks[index].name = name
            }
        }
    }

    func addOrUpdateTaskOfGroup(item: ModelPairOpt<Task, TaskGroup>, _ name: String) {
        item.apply { group in
            addNewTaskToGroup(group, name)
        } or: { group, task in
            updateTaskOfGroup(group, task, name)
        }
    }

    func deleteTaskOfGroup(_ group: TaskGroup, _ task: Task) {
        list.groups.withElement(group) { i in
            list.groups[i].tasks.removeElement(task)
        }
    }

    // ---------------------------------------------------------------- groups

    private func addNewTaskGroup(_ name: String) {
        list.groups.append(TaskGroup(name: name))
    }

    func deleteTaskGroup(_ taskGroup: TaskGroup) {
        list.groups.removeElement(taskGroup)
    }

    private func updateTaskGroup(_ taskGroup: TaskGroup, _ name: String) {
        list.groups.withElement(taskGroup) { index in
            list.groups[index].name = name
        }
    }

    func addOrUpdateTaskGroup(item: ModelOpt<TaskGroup>, _ name: String) {
        item.apply {
            addNewTaskGroup(name)
        } or: { taskGroup in
            updateTaskGroup(taskGroup, name)
        }
    }

    func reorder(source: TaskGroup, destination: TaskGroup) {
        let fromIndex = list.groups.firstIndex(of: source)
        let toIndex = list.groups.firstIndex(of: destination)
        guard (fromIndex != nil && toIndex != nil) else { return }
        reorderTaskGroups(from: [fromIndex!], to: toIndex!)
    }

    private func reorderTaskGroups(from set: IndexSet, to destinationIndex: Int) {
        list.groups.move(fromOffsets: set, toOffset: destinationIndex)
    }
}
