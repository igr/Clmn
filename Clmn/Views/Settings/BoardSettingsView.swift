import SwiftUI

struct BoardSettingsView: View {
    
    @AppStorage(SETTINGS_TASK_CHECKBOX_IMAGE) private var taskCheckboxImage = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Toggle("Use checkbox icon for completed tasks", isOn: $taskCheckboxImage).padding()
            }
            Spacer()
        }
    }
}
struct BoardSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        BoardSettingsView()
    }
}
