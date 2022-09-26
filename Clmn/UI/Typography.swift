import CoreData
import SwiftUI

struct Typography {
    let sideboard: Font!
    let formField: Font!

    init() {
        self.sideboard = Font.system(size: 14).weight(.semibold)
        self.formField = Font.system(size: 14)
    }
}

extension Font {
    static let App = Typography()
}
