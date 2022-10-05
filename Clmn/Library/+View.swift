import SwiftUI

extension View {

    /// Solution to control attributes inclusion/exclusion.
    /// Usage: `.if(colored) { view in view.background(Color.blue) }`
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) ->  Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }

}
