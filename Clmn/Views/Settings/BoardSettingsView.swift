import SwiftUI

struct BoardSettingsView: View {
    
    @AppStorage(SETTINGS_TASK_CHECKBOX_IMAGE) private var taskCheckboxImage = false
    @AppStorage(SETTINGS_TASK_SELECTABLE) private var taskSelectable = true
    
    var body: some View {
        VStack(spacing:20) {
            Toggle("Use checkbox icon for completed tasks", isOn: $taskCheckboxImage)
            Toggle("Select a task on a click for focus", isOn: $taskSelectable)
            Spacer()
        }.padding()
    }
}
struct BoardSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        BoardSettingsView()
    }
}
