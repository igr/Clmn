import SwiftUI

let SETTINGS_TASK_CHECKBOX_IMAGE = "taskCheckboxImage"
let SETTINGS_TASK_SELECTABLE = "taskSelectable"

struct SettingsView: View {
    var body: some View {
        TabView {
            BoardSettingsView()
            .tabItem {
                Label("Board", systemImage: Icons.board)
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
