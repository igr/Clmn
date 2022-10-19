import os
import SwiftUI

let APP_SITE = "https://clmnapp.com"
let APP_EMAIL = "clmn@igo.rs"
let APP_GROUP = "ac.obl.clmn"
let APP_NAME = "Clmn"
let APP_HOST = "clmn"

/// Meta-data
let mainBundle = Bundle.main
// application version, just a simple counter
let APP_BUILD = Int(mainBundle.appBuild) ?? 0
// application data version; the version of the models.
let APP_DATA_VERSION = 1

@main
struct ClmnApp: App {

    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: ClmnApp.self)
    )
    
    @AppStorage("appThemeSetting") private var appThemeSetting = Appearance.system
    @Environment(\.colorScheme) var colorScheme

    @StateObject var addExample = AddExampleModel()

    init() {
        disallowTabbingMode()
        metaData()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(addExample)
            .font(.system(.body, design: .default))
            .onAppear {
                Appearance.applyTheme(appThemeSetting)
            }
            .onChange(of: appThemeSetting) { newValue in
                Appearance.applyTheme(newValue)
            }
            // Handle minimize and show of the window
            .onReceive(NotificationCenter.default.publisher(for: NSApplication.didChangeOcclusionStateNotification)) { _ in
                if let window = NSApp.windows.first, window.isMiniaturized {
                    NSWorkspace.shared.runningApplications.first(where: {
                        $0.activationPolicy == .regular
                    })?.activate(options: .activateAllWindows)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in
                if let window = NSApp.windows.first {
                    window.deminiaturize(nil)
                }
            }
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
        .commands {
            MenuLine_File_NewWindow_Disable()
            MenuLine_Help_SupportEmail()
            MenuLine_View_ToggleBoards()
            MenuLine_View_Appearance()
            MenuLine_Help_Examples()
        }
        Settings {
            SettingsView()
        }
    }
    
    // ---------------------------------------------------------------- meta
    
    fileprivate func metaData() {
        let appMetaData = services.app.fetchMetadata()
        upgradeData(from: appMetaData.dataVersion, to: APP_DATA_VERSION)
        
        // at this point the application is updated
        services.app.storeMetadata(appVersion: APP_BUILD,
                                   dataVersion: APP_DATA_VERSION)
        
        Self.logger.info("\(APP_NAME): \(APP_BUILD)//\(APP_DATA_VERSION)")
    }
    
    // ---------------------------------------------------------------- menus

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
    fileprivate func MenuLine_Help_Examples() -> CommandGroup<TupleView<(Button<Text>, Button<Text>)>> {
        CommandGroup(replacing: .help) {
            Button("Support Email") {
                NSWorkspace.shared.open(URL(string: "mailto:\(APP_EMAIL)")!)
            }
            Button("Add Example") {
                addExample.toggle()
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
