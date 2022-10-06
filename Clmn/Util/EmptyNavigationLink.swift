import SwiftUI

struct EmptyNavigationLink<Destination: View>: View {
    let lazyDestination: LazyView<Destination>
    let isActive: Binding<Bool>

    init<T>(
        @ViewBuilder destination: @escaping (T) -> Destination,
        selection: Binding<T?>
    ) {
        lazyDestination = LazyView(destination(selection.wrappedValue!))
        isActive = .init(
            get: { selection.wrappedValue != nil },
            set: { isActive in
                if !isActive {
                    selection.wrappedValue = nil
                }
            }
        )
    }

    var body: some View {
        NavigationLink(
            destination: lazyDestination,
            isActive: isActive,
            label: { EmptyView() }
        ).buttonStyle(.plain)
    }
}
