import SwiftUI

struct SheetHeader: View {
    private var title: String
    init(_ title: String) {
        self.title = title
    }
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .padding()
        }
        .frame(
            maxWidth: .infinity
        )
    }
}

struct SheetHeader_Previews: PreviewProvider {
    static var previews: some View {
        SheetHeader("Hello")
    }
}
