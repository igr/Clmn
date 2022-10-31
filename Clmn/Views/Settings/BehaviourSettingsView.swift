import SwiftUI

struct BehaviourSettingsView: View {

    @AppStorage(SETTINGS_HOVER_EDIT) private var hoverEdit = true

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Toggle("Use hover editing tools", isOn: $hoverEdit)
            .font(Font.App.formField)
            .padding([.top], 20)
            FormDescription("When enabled, hovering over the board elements shows editing tools. When disabled, you may still use the context-menu instead.")
            .padding([.leading], 20)

            Spacer()
        }
        .padding()
    }
}

struct BehaviourSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        BehaviourSettingsView()
    }
}
