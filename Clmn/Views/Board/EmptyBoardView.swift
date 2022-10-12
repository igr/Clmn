import SwiftUI

struct EmptyBoardView: View {
    @Binding var taskListDetails: ModelOpt<TaskList>?

    var body: some View {
        VStack {
            Spacer()
            Image("AppBW")
            .resizable()
            .scaledToFit()
            .frame(width: 256, height: 256)
            Text("Add some Lists for your tasks...")
            .font(.system(size: 16).italic())
            .foregroundColor(Color.secondary)
            Image(systemName: "arrow.down")
            Spacer()
            Button(
                action: { taskListDetails = ModelOpt<TaskList>.ofNew() },
                label: {
                    Image(systemName: Icons.addList)
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
