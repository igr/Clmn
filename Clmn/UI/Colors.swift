import CoreData
import SwiftUI

struct AppColors {
    let sidebarBackground = Color("SidebarBackgroundColor")
    
    let listBackground = Color("ListBackground")
    
    let formGray = Color.gray
    let formSheetBackground = Color.primary
    
    let textInvert = Color("TextInvert")
}

extension Color {
    static let App = AppColors()
}
