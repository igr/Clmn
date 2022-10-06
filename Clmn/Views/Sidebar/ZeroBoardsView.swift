import SwiftUI

struct ZeroBoardView: View {
    @State var currentSelection: Bool? = true

    var body: some View {
        EmptyNavigationLink(
            destination: { _ in  DetailView() },
            selection: $currentSelection
        )
    }
}
struct DetailView: View {
    var body: some View {
        /// TODO: Add cool page!
        Text("It's a blast!")
    }
}
