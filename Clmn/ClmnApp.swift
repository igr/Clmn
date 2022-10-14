import SwiftUI

let APP_SITE = "https://clmnapp.com"
let APP_EMAIL = "clmn@igo.rs"
let APP_GROUP = "ac.obl.clmn"
let APP_NAME = "Clmn"
let APP_HOST = "clmn"

/// Meta-data
// application version, just a simple counter
let APP_VERSION = 1
// application data version; the version of the models.
let APP_DATA_VERSION = 1

@main
struct ClmnApp: App {
    @AppStorage("appThemeSetting") private var appThemeSetting = Appearance.system
    @Environment(\.colorScheme) var colorScheme

    @StateObject var addExample = AddExampleModel()

    init() {
        disallowTabbingMode()
        let appMetaData = services.app.fetchMetadata()
        if (appMetaData.dataVersion != APP_DATA_VERSION) {
            // upgrade!
        }
        print("\(APP_NAME) \(appMetaData.appVersion)-\(appMetaData.dataVersion)")
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
