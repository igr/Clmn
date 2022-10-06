import SwiftUI

@main
struct ClmnApp: App {
    @AppStorage("appThemeSetting") private var appThemeSetting = Appearance.system
    @Environment(\.colorScheme) var colorScheme

    init() {
        disallowTabbingMode()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
            .font(.system(.body, design: .rounded))
            .onAppear {
                Appearance.applyTheme(appThemeSetting)
            }
            .onChange(of: appThemeSetting) { newValue in
                Appearance.applyTheme(newValue)
            }
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
        .commands {
            MenuLine_File_NewWindow_Disable()
            MenuLine_Help_SupportEmail()
            MenuLine_Help_Examples()
            MenuLine_View_ToggleBoards()
            MenuLine_View_Appearance()
            MenuLine_App_About()
        }
    }

    /// Adds some menu button into Help menu.
    fileprivate func MenuLine_Help_SupportEmail() -> CommandGroup<Button<Text>> {
        CommandGroup(after: CommandGroupPlacement.help) {
            Button("Support Email") {
                NSWorkspace.shared.open(URL(string: "mailto:\(APP_EMAIL)")!)
            }
        }
    }

    /// Disables "File -> New window" menu item (make it absent in release build).
    fileprivate func MenuLine_File_NewWindow_Disable() -> CommandGroup<EmptyView> {
        CommandGroup(replacing: .newItem) {
        }
    }

    /// Adds some menu button into Help menu.
    fileprivate func MenuLine_Help_Examples() -> CommandGroup<Button<Text>> {
        CommandGroup(after: CommandGroupPlacement.help) {
            Button("Add Example") {
                createExample()
                // TODO: How to refresh the app?
            }
        }
    }

    /// Adds some items into the View menu.
    fileprivate func MenuLine_View_ToggleBoards() -> CommandGroup<Button<Text>> {
        CommandGroup(before: CommandGroupPlacement.toolbar) {
            Button("Toggle Boards sidebar") {
                SideBarUtil.toggleSidebar()
            }
        }
    }

    /// Adds About menu item.
    fileprivate func MenuLine_App_About() -> CommandGroup<Button<Text>> {
        CommandGroup(replacing: CommandGroupPlacement.appInfo) {
            Button("About \(Bundle.main.appName)") {
                NSApplication.shared.orderFrontStandardAboutPanel(
                    options: [
                        NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                            string: APP_DESCRIPTION,
                            attributes: [
                                NSAttributedString.Key.font: NSFont.boldSystemFont(ofSize: NSFont.smallSystemFontSize)
                            ]
                        ),
                        NSApplication.AboutPanelOptionKey(
                            rawValue: "Copyright"
                        ): APP_COPYRIGHT
                    ]
                )
            }
        }
    }

    /// Adds Appearance in View menu.
    fileprivate func MenuLine_View_Appearance() -> CommandGroup<Picker<Text, Appearance, ForEach<[Appearance], String, some View>>> {
        CommandGroup(before: CommandGroupPlacement.toolbar) {
            Picker("Appearance", selection: $appThemeSetting) {
                ForEach(Appearance.allCases) { appearance in
                    Text(appearance.rawValue.capitalized)
                    .tag(appearance)
                }
            }
        }
    }
}

fileprivate func disallowTabbingMode() {
    NSWindow.allowsAutomaticWindowTabbing = false
}
