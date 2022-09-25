class BoardService {

    func fetchBoards() -> [Board] {
        /// TODO: Load all boards from the Fridge and sort them by order!
        /// select * from boards order by board.id
        [
            Board(name: "One", order: 1),
            Board(name: "Two", order: 2)
        ]
    }
}
