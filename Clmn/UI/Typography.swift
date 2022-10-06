import CoreData
import SwiftUI

struct Typography {
    let sideboard: Font!
    let formField: Font!
    let formSheetHeader: Font!
    let listTitle: Font!
    let groupName: Font!
    let taskIcon: Font!

    init() {
        self.sideboard = Font.system(size: 14).weight(.semibold)
        self.formField = Font.system(size: 14)
        self.formSheetHeader = Font.system(size: 14).bold()
        self.listTitle = Font.custom("PeriodicoDisplay-Bd", size: 32)
        self.groupName = Font.custom("PeriodicoDisplay-Rg", size: 22)
        self.taskIcon = Font.system(size: 16, design: .monospaced)
    }
}

extension Font {
    static let App = Typography()
}
