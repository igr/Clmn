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
        VStack {
            Spacer()
            Image("AppBW")
                .resizable()
                .scaledToFit()
                .frame(width: 256, height: 256)
            Text("It's a blast!")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.secondary)
            Spacer()
            HStack(alignment: .center) {
                Image(systemName: "arrow.left")
                Text("Add some Board to get started...")
                    .font(.system(size: 16).italic())
                    .foregroundColor(Color.secondary)
                Spacer()
            }
            .padding()
            .padding(.bottom, 10)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
