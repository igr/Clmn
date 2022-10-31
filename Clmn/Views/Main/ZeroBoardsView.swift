import SwiftUI

struct ZeroBoardView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("AppBW")
                .resizable()
                .scaledToFit()
                .frame(width: 256, height: 256)
            Text("Just Columns & Tasks")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color.secondary)
            Spacer()
            HStack(alignment: .center) {
                Image(systemName: "arrow.left")
                Text("Add some Boards to get started...")
                    .font(.system(size: 16).italic())
                    .foregroundColor(Color.secondary)
                Spacer()
            }
            .padding()
            .padding(.bottom, 4)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ZeroBoardView()
    }
}
