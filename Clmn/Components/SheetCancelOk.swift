import SwiftUI

struct SheetCancelOk: View {
    @Environment(\.dismiss) var dismiss

    var onOk: () -> Void

    var body: some View {
        HStack() {
            Spacer()
            Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
                .frame(maxWidth: 80)
            })
            .keyboardShortcut(.cancelAction)
            Button(action: {
                withAnimation {
                    onOk()
                }
                dismiss()
            }, label: {
                Text("OK")
                .frame(maxWidth: 80)
            })
            .keyboardShortcut(.defaultAction)
            .tint(.accentColor)
        }

    }
}

struct SheetCancelOk_Previews: PreviewProvider {
    static var previews: some View {
        SheetCancelOk(onOk: {})
    }
}
