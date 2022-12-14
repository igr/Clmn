import CoreData
import SwiftUI

struct AppColors {
    let sidebarBackground = Color("SidebarBackgroundColor")
    let sidebarSelected = Color.selectedTextBackground

    let listBackground = Color("ListBackground")
    let listSplitLine = Color.windowBackground
    let listSubtitle = Color.secondary
    let listSelect = Color("ListSelect")
    let listText = Color.text
    let listOffText = Color("ListOffText")

    let formGray = Color.gray
    let formSheetBackground = Color.primary
    let formBorders = Color.secondary

    let textInvert = Color("TextInvert")
    let textWarn = Color.red
    let taskNote = Color("TaskNote")

    let taskCompleted = Color.gray

    let taskColors = [
        Color("TaskColor0"),
        Color("TaskColor1"),
        Color("TaskColor2"),
        Color("TaskColor3"),
        Color("TaskColor4"),
        Color("TaskColor5")
    ]
}

extension Color {
    static let App = AppColors()
}
