import SwiftUI

class SideBarUtil {
    static func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct SplitViewAccessor: NSViewRepresentable {
    @Binding var sideCollapsed: Bool
    @Binding var onInit: (Bool) -> Void

    func makeNSView(context: Context) -> some NSView {
        let view = MyView()
        view.sideCollapsed = _sideCollapsed
        view.onInit = _onInit
        return view
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {
    }

    class MyView: NSView {
        var sideCollapsed: Binding<Bool>?
        var onInit: Binding<(Bool) -> Void>?

        weak private var controller: NSSplitViewController?
        private var observer: Any?

        override func viewDidMoveToWindow() {
            super.viewDidMoveToWindow()
            var superView = self.superview

            // find split view through hierarchy
            while superView != nil, !superView!.isKind(of: NSSplitView.self) {
                superView = superView?.superview
            }
            guard let sview = superView as? NSSplitView else { return }

            controller = sview.delegate as? NSSplitViewController   // delegate is our controller
            if let sideBar = controller?.splitViewItems.first {     // now observe for state
                let initState = sideBar.isCollapsed
                sideCollapsed?.wrappedValue = initState
                onInit?.wrappedValue(initState);
                observer = sideBar.observe(\.isCollapsed, options: [.new]) { [weak self] _, change in
                    if let value = change.newValue {
                        self?.sideCollapsed?.wrappedValue = value    // << here !!
                    }
                }
            }
        }
    }
}
