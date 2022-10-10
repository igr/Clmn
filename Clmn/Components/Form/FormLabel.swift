import SwiftUI

struct FormLabel: View {
    private var text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
        .padding(.top, 2)
        .frame(height: 18)
        .font(Font.App.formField)
    }
}

struct FormLabel_Previews: PreviewProvider {
    static var previews: some View {
        FormLabel("Hello")
    }
}
