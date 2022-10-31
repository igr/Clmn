import SwiftUI

struct FormDescription: View {
    private var text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
        .fixedSize(horizontal: false, vertical: true)
        .padding(.top, 2)
        .font(Font.App.formDescription)
    }
}

struct FormDescription_Previews: PreviewProvider {
    static var previews: some View {
        FormDescription("This is a description")
    }
}
