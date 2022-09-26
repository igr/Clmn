import Cocoa

class WindowController: NSWindowController, NSWindowDelegate {
    override func windowDidLoad() {
        super.windowDidLoad()
        windowFrameAutosaveName = APP_NAME
    }

    func windowDidBecomeMain(_ notification: Notification) {
        window?.title = APP_TITLE
    }
}
