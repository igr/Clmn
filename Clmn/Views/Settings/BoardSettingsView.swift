import SwiftUI

struct BoardSettingsView: View {
    
    @AppStorage(SETTINGS_TASK_CHECKBOX_IMAGE) private var taskCheckboxImage = false
    @AppStorage(SETTINGS_TASK_SELECTABLE) private var taskSelectable = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Toggle("Use checkbox icon for completed tasks", isOn: $taskCheckboxImage)
                .font(Font.App.formField)
                .padding([.top], 20)
            FormDescription("When selected, the completed tasks will be marked with a checkbox icon instead of filled square.")
                .padding([.leading], 20)
            
            Toggle("Use dark background for selected task", isOn: $taskSelectable)
                .font(Font.App.formField)
                .padding([.top], 20)
            FormDescription("Enables the dark background of the selected task for better visibility.")
                .padding([.leading], 20)
            
            Spacer()
        }.padding()
    }
}
struct BoardSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        BoardSettingsView()
    }
}
