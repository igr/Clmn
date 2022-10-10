import SwiftUI

struct FormTextField: View {

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
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .padding([.vertical], 9)
                .padding(.leading, 16)
                .foregroundColor(Color.App.formGray)
            MacTextEditor(
                placeholderText: placeholder,
                placeholderColor: Color.App.formGray,
                text: $text,
                singleLine: true
            )
            .padding([.top], 6)

            // original take
//            TextField("", text: $text)
//                .placeholder(when: text.isEmpty) {
//                    Text(placeholder)
//                        .foregroundColor(Color.App.formGray)
//                }
//                .textFieldStyle(.plain)
        }
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(.black, lineWidth: 1/3)
                .opacity(0.5)
        )
        .font(Font.App.formField)
        .frame(height: 30)
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}

struct FormTextField_Previews: PreviewProvider {
    static var previews: some View {
        FormTextField(
            text: .constant(""),
            placeholder: "Yes",
            imageName: "line.3.horizontal")
    }
}
