import SwiftUI

struct ContentView: View {

    @StateObject var boardsVM = BoardsViewModel()

    @State private var boardDetails: ModelOpt<Board>?
    @State private var addBoard: Bool

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        NavigationView {
            VStack {
                VStack {
                    ForEach(boardsVM.boards, id: \.id) { board in
                        NavigationLink(destination: BoardView(board)) {
                            Text(board.name)
                            .frame(maxWidth: .infinity)
                        }
                        .contextMenu {
                            Button {
                                boardDetails = ModelOpt<Board>.of(board)
                            } label: {
                                Label("Edit Board", systemImage: Constants.Icons.squareAndPencil)
                                .labelStyle(.titleAndIcon)
                            }
                        }
                    }
                }
                .padding()
                Spacer()
                Divider()
                HStack {
                    Button(
                        action: { boardDetails = ModelOpt<Board>.ofNew() },
                        label: {
                            Image(systemName: Constants.Icons.plusSquareOnSquare)
                            Text("Add Board")
                        }
                    )
                    .controlSize(.large)
                }
                .padding()
            }
            .sheet(item: $boardDetails) { item in
                BoardSheet(board: item.model) { boardName in
                    if (item.isNew()) {
                        boardsVM.addNewBoard(boardName)
                    } else {
                        boardsVM.updateBoard(item.get(), boardName)
                    }
                }
            }
            .onAppear {
                boardsVM.loadBoards()
            }
        }
        .navigationViewStyle(.columns)
    }
}
