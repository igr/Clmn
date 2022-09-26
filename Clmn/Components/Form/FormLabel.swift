import SwiftUI

struct FormLabel: View {
    private var text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        HStack {
            Text(text)
                .padding(.top, 10)
                .frame(height: 18)
            Spacer()
        }
    }
}

struct FormLabel_Previews: PreviewProvider {
    static var previews: some View {
        FormLabel("Hello")
    }
}
