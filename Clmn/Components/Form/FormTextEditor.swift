import SwiftUI

struct FormTextEditor: View {

    @Binding var text: String
    var placeholder: String
    let imageName: String

    @Environment(\.colorScheme) var colorScheme

    init(text: Binding<String>, placeholder: String, imageName: String) {
        self._text = text
        self.placeholder = placeholder
        self.imageName = imageName
    }

    var body: some View {
        HStack {
            VStack {
                Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .padding([.vertical], 8)
                .padding(.leading, 16)
                .foregroundColor(Color.App.formGray)
                Spacer()
            }
            MacTextEditor(
                placeholderText: placeholder,
                text: $text,
                shouldMoveCursorToEnd: .constant(true))
            .padding([.top,.bottom], 6)
        }
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
            .strokeBorder(.black, lineWidth: 1/3)
            .opacity(0.5)
        )
        .font(Font.App.formField)
        .frame(height: 120)
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}

struct FormTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        FormTextEditor(
            text: .constant(""),
            placeholder: "Yes",
            imageName: "line.3.horizontal")
    }
}
