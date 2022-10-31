import SwiftUI

let SETTINGS_TASK_CHECKBOX_IMAGE = "taskCheckboxImage"
let SETTINGS_TASK_SELECTABLE = "taskSelectable"
let SETTINGS_HOVER_EDIT = "hoverEdit"

struct SettingsView: View {
    var body: some View {
        TabView {
            BoardSettingsView()
            .tabItem {
                Label("General", systemImage: Icons.settingsGeneral)
            }
            BehaviourSettingsView()
            .tabItem {
                Label("Behaviour", systemImage: Icons.settingsBehaviour)
            }
        }
        .frame(width: 450, height: 250)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
