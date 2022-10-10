import SwiftUI
import AppKit

/*
 Because all core data fields are optional, you have to wrap it into Binding.
 And as you're using core data and may face a lot of optionals, you can create an extension.
 Usage: $newTask.name.unwrap(defaultValue: "")
 */
extension Binding {
    func unwrap<T>(defaultValue: T) -> Binding<T> where Value == Optional<T> {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
