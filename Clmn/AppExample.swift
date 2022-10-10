/// Creates example
func createExample() {
    let allBoardsVM = AllBoardsVM()
    allBoardsVM.loadBoards()

    with(allBoardsVM.addNewBoard("👔 Clients")) { board in
        let allListsVM = AllTaskListsVM()
        allListsVM.loadLists(board: board)

        with(allListsVM.addNewList("🚕 TzarCars", description: "Cars reseller website")) { list in
            let listVM = TaskListVM(list)

            listVM.addNewTask("Read documentation")
            listVM.addNewTask("☎️ Schedule a call")
            listVM.addNewTask("Fix _Felix_ **issue**!!!")
            listVM.addNewTask("Upgrade components", progress: 1)

            allListsVM.apply(from: listVM.list)
        }

        with(allListsVM.addNewList("🏕 Camparoo", description: "Camping _kangaroos_, with **style**")) { list in
            let listVM = TaskListVM(list)

            listVM.addNewTask("Migrate to new server")
            with(listVM.addNewTaskGroup("Database")) { group in
                listVM.addNewTask(toGroup: group, "1️⃣ Migrate tables")
                listVM.addNewTask(toGroup: group, "2️⃣ Migrate data", progress: 2)
            }

            allListsVM.apply(from: listVM.list)
        }

        with(allListsVM.addNewList("💃 ThirtySt. Dancing", description: "Dance, dance, _dance_!")) { list in
            let listVM = TaskListVM(list)

            listVM.addNewTask("📙 Design booklet")
            with(listVM.addNewTaskGroup("🧠 Brainstorming")) { group in
                listVM.addNewTask(toGroup: group, "Try retro view; looking for 80-ies retro vibe")
                listVM.addNewTask(toGroup: group, "Record new videos? Upload them to new YouTube channel")
                listVM.addNewTask(toGroup: group, "Apply the new font")
            }
            with(listVM.addNewTaskGroup("👩‍💻 Dev team")) { group in
                listVM.addNewTask(toGroup: group, "Clean up code smells")
                listVM.addNewTask(toGroup: group, "Add **README.ME** to _all_ repos")
                listVM.addNewTask(toGroup: group, "Implement new Github hook")
            }

            allListsVM.apply(from: listVM.list)
        }

        allListsVM.saveLists()
    }

    with(allBoardsVM.addNewBoard("📘 Kanban")) { board in
        let allListsVM = AllTaskListsVM()
        allListsVM.loadLists(board: board)

        with(allListsVM.addNewList("✴️ To-Do")) { list in
            let listVM = TaskListVM(list)

            listVM.addNewTask("Fix scroll issues")
            listVM.addNewTask("Add /wires API endpoint")

            with(listVM.addNewTaskGroup("🧊 Backlog")) { group in
                listVM.addNewTask(toGroup: group, "Clean up code smells", completed: true)
                listVM.addNewTask(toGroup: group, "Add **README.ME** to _all_ repos")
                listVM.addNewTask(toGroup: group, "Implement new Github hook")
            }

            allListsVM.apply(from: listVM.list)
        }

        with(allListsVM.addNewList("🚀 In-Progress")) { list in
            let listVM = TaskListVM(list)

            listVM.addNewTask("Connectivity issue")
            listVM.addNewTask("Refactor module", progress: 2)

            allListsVM.apply(from: listVM.list)
        }


        with(allListsVM.addNewList("✅ Done")) { list in
            let listVM = TaskListVM(list)

            listVM.addNewTask("Rename package", completed: true)
            listVM.addNewTask("🚀 Release v1.2", completed: true)
            listVM.addNewTask("Fix _drag-n-drop_ issue!", completed: true)

            allListsVM.apply(from: listVM.list)
        }

        allListsVM.saveLists()
    }

    with(allBoardsVM.addNewBoard("❤️ My Life")) { board in
        let allListsVM = AllTaskListsVM()
        allListsVM.loadLists(board: board)

        with(allListsVM.addNewList("🏡 House", description: "Mi casa tu casa")) { list in
            let listVM = TaskListVM(list)

            listVM.addNewTask("Fix kitchen cupboard")
            listVM.addNewTask("🧽 Clean room")

            allListsVM.apply(from: listVM.list)
        }

        with(allListsVM.addNewList("🛒 Buy stuff")) { list in
            let listVM = TaskListVM(list)

            listVM.addNewTask("**New keyboard**")
            listVM.addNewTask("New T-Shirt")

            with(listVM.addNewTaskGroup("🍅 Grocery list")) { group in
                listVM.addNewTask(toGroup: group, "Tomatoes")
                listVM.addNewTask(toGroup: group, "Potato")
                listVM.addNewTask(toGroup: group, "Mozzarella")
                listVM.addNewTask(toGroup: group, "Wine")
                listVM.addNewTask(toGroup: group, "Bread")
            }

            allListsVM.apply(from: listVM.list)
        }

        with(allListsVM.addNewList("👩‍💻 Website")) { list in
            let listVM = TaskListVM(list)

            listVM.addNewTask("Update blog")
            listVM.addNewTask("Change MailX with something else.")
            listVM.addNewTask("Buy new domain name")

            allListsVM.apply(from: listVM.list)
        }

        with(allListsVM.addNewList("⚙️ Renovation")) { list in
            let listVM = TaskListVM(list)

            listVM.addNewTask("Dinning table", progress: 1)
            listVM.addNewTask("Measure kitchen")
            listVM.addNewTask("Call John and give him measurements: 220x80, depth: 60, white oak")
            listVM.addNewTask("Wooden tray")

            allListsVM.apply(from: listVM.list)
        }

        allListsVM.saveLists()
    }


    // finally
    allBoardsVM.saveBoards()
}

private func with<T>(_ taskList: T, _ action: (T) -> Void = {_ in }) {
    action(taskList)
}
