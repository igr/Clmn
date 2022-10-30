import SwiftUI

public struct AppSplitView<P: View, S: View>: View {
    private let primaryMinWidth: CGFloat = 150
    @AppStorage("sidebar.hidden") private var primaryHidden: Bool = false
    @AppStorage("sidebar.width") private var primaryWidth: Double = 150

    let primary: P
    let secondary: S

    public var body: some View {
        HStack(spacing: 0) {
            if (!primaryHidden) {
                primary
                .frame(width: primaryWidth)
            }

            SplitDivider(minDimension: primaryMinWidth, dimension: $primaryWidth)
            .onTapGesture(count: 2) {
                primaryHidden.toggle()
            }

            secondary
            .frame(maxWidth: .infinity)
        }
    }

    init(sidebar primary: P, main secondary: S) {
        self.primary = primary
        self.secondary = secondary
    }
}

fileprivate struct SplitDivider: View {
    private var minDimension: Double
    @Binding var dimension: Double
    @State private var dimensionStart: Double?
    @State private var dragStarted = true

    public init(minDimension: Double, dimension: Binding<Double>) {
        self.minDimension = minDimension
        self._dimension = dimension
    }

    public var body: some View {
        Color.red
        .frame(width: 10)
        .gesture(drag)
    }

    var drag: some Gesture {
        DragGesture(minimumDistance: 10, coordinateSpace: CoordinateSpace.global)
        .onChanged { drag in
            if (dragStarted) {
                NSCursor.resizeLeftRight.push()
                dragStarted = false
            }
            if dimensionStart == nil {
                dimensionStart = dimension
            }
            let delta = drag.location.x - drag.startLocation.x
            dimension = dimensionStart! + delta
            if (dimension < minDimension) {
                dimension = minDimension
            }
        }
        .onEnded { val in
            dimensionStart = nil
            NSCursor.pop()
            dragStarted = true
        }
    }
}
