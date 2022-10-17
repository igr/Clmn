import SwiftUI

struct SheetCancelOk: View {
    @Environment(\.dismiss) var dismiss

    var isUpdate: Bool = false
    var onOk: () -> Void
    var onDelete: () -> Void = {}

    @State private var areYouSure: Bool = false

    var body: some View {
        HStack {
            if (isUpdate) {
                Button(role: .destructive, action: {
                    if (areYouSure == false) {
                        areYouSure = true
                    } else {
                        withAnimation {
                            onDelete()
                        }
                        dismiss()
                    }
                }, label: {
                    Text(areYouSure ? "DELETE?" : "Delete")
                    .frame(maxWidth: 60)
                    .foregroundColor(Color.App.textWarn)
                })
            }

            Spacer()

            Button(role: .cancel, action: {
                dismiss()
            }, label: {
                Text("Cancel")
                .frame(maxWidth: 60)
            })
            .keyboardShortcut(.cancelAction)

            Button(action: {
                withAnimation(if: !isUpdate) {
                    onOk()
                }
                dismiss()
            }, label: {
                Text("OK")
                .frame(maxWidth: 60)
            })
            .keyboardShortcut(.defaultAction)
            .tint(.accentColor)
        }
        .padding(.top, 10)
    }
}

struct SheetCancelOk_Previews: PreviewProvider {
    static var previews: some View {
        SheetCancelOk(onOk: {}, onDelete: {})
    }
}
