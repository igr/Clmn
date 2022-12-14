import SwiftUI

struct FormTextEditor: View {

    @Binding var text: String
    var placeholder: String
    let imageName: String
    let height: Int

    @Environment(\.colorScheme) var colorScheme

    init(text: Binding<String>, placeholder: String, imageName: String, height: Int = 120) {
        self._text = text
        self.placeholder = placeholder
        self.imageName = imageName
        self.height = height
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
                placeholderColor: Color.App.formGray,
                text: $text,
                font: Font.App.formFieldFont
            )
            .padding([.top,.bottom], 6)
        }
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(Color.App.formBorders, lineWidth: 1/3)
            .opacity(0.5)
        )
        .font(Font.App.formField)
        .frame(height: CGFloat(height))
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
