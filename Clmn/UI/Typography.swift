import CoreData
import SwiftUI

struct Typography {
    let sideboard: Font!
    let formField: Font!
    let formLabel: Font!
    let formFieldFont: NSFont!
    let formSheetHeader: Font!
    let listTitle: Font!
    let listSubtitle: Font!
    let groupName: Font!
    let taskIcon: Font!
    let taskText: Font!

    init() {
        self.sideboard = Font.system(size: 14).weight(.semibold)
        self.formField = Font.system(size: 14)
        self.formFieldFont = .systemFont(ofSize: 14, weight: .regular)
        self.formLabel = Font.system(size: 14)
        self.formSheetHeader = Font.system(size: 14).bold()
        self.listTitle = Font.custom("PeriodicoDisplay-Bd", size: 32)
        self.listSubtitle = Font.system(size: 16, design: .default)
        self.groupName = Font.custom("PeriodicoDisplay-Rg", size: 22)
        self.taskIcon = Font.system(size: 16, design: .monospaced)
        self.taskText = Font.system(size: 16)
    }
}

extension Font {
    static let App = Typography()
}
