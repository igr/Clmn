import SwiftUI

struct SheetHeader: View {
    private var title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                Image(systemName: Icons.formSheetHeader)
                Text(title)
                    .padding([.top, .bottom])
                Spacer()
            }
            .frame(
                maxWidth: .infinity
            )
            .font(Font.App.formSheetHeader)
            .colorInvert()
            .background(Color.App.formSheetBackground)
        }
        Spacer().frame(height: 20)
    }
}

struct SheetHeader_Previews: PreviewProvider {
    static var previews: some View {
        SheetHeader("Hello")
    }
}
