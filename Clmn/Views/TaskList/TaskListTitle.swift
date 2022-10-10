import SwiftUI

struct TaskListTitle: View {
    var list: TaskList

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(list.title)
                .font(Font.App.listTitle)
            }
            .padding(.top, 10)
            Text((list.description ?? "").markdown())
            .font(Font.App.listSubtitle)
            .foregroundColor(Color.App.listSubtitle)
        }
        .contentShape(Rectangle())
        .padding(.horizontal)
        .padding(.bottom, 4)
    }

}
