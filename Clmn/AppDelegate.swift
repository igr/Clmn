import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("App finished launching…")
    }

    func applicationWillTerminate(_ notification: Notification) {
        print("App is about to terminate")
    }

    private var aboutBoxWindowController: NSWindowController?

    /// Shows About window.
    func showAboutWnd() {
        if aboutBoxWindowController == nil {
            let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable, /* .resizable,*/ .titled]
            let window = NSWindow()
            window.styleMask = styleMask
            window.title = "About \(Bundle.main.appName)"
            window.contentView = NSHostingView(rootView: AboutView())
            window.center()
            aboutBoxWindowController = NSWindowController(window: window)
        }
        aboutBoxWindowController?.showWindow(aboutBoxWindowController?.window)
    }

    var myWindowController: WindowController!

    func openAppWindow() {
        myWindowController.showWindow(self)
        NSApp.activate(ignoringOtherApps: true)
    }
}

