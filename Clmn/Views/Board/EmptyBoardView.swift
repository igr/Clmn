import SwiftUI

struct EmptyBoardView: View {
    @Binding var taskListDetails: ModelOpt<TaskList>?

    var body: some View {
        VStack {
            Spacer()
            Button(
                action: { taskListDetails = ModelOpt<TaskList>.ofNew() },
                label: {
                    Image(systemName: Icons.plusSquareFill)
                    Text("Add List")
                }
            )
            .controlSize(.large)
        }
        .padding()
    }
}

struct EmptyBoardView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyBoardView(taskListDetails: .constant(ModelOpt<TaskList>.ofNew()))
    }
}
