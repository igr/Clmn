import SwiftUI

class CursorUtil {

    public static func changeCursorOnHover(_ isHovered: Bool, cursor: NSCursor) {
        DispatchQueue.main.async {
            if isHovered {
                cursor.push()
            } else {
                NSCursor.pop()
            }
        }
    }

}
