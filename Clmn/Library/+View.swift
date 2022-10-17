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

func withAnimation(if condition: Bool, block: () -> Void) {
    if condition {
        withAnimation {
            block()
        }
    } else {
        block()
    }
}
