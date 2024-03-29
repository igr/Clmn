import os
import SwiftUI

let APP_SITE = "https://clmnapp.com"
let APP_EMAIL = "clmn@igo.rs"
let APP_GROUP = "studio.oblac.clmn"
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
    
    @AppStorage("sidebar.hidden") private var primaryHidden: Bool = false
    
    @StateObject var addExample = AddExampleModel()
    @StateObject var dragBoard: DragBoardModel = DragBoardModel()
    @StateObject var dragTask: DragTaskModel = DragTaskModel()
    @StateObject var dragTaskList: DragTaskListModel = DragTaskListModel()
    @StateObject var dragTaskGroup: DragTaskGroupModel = DragTaskGroupModel()
    
    @Environment(\.openWindow) private var openWindow
    @State var isMainWindowOpen = false
    
    init() {
        disallowTabbingMode()
        metaData()
    }
    
    var body: some Scene {
        WindowGroup(id: "MainWindow") {
            VStack(spacing: 0) {
                MainView()
            }
            .environmentObject(dragBoard)
            .environmentObject(dragTask)
            .environmentObject(dragTaskList)
            .environmentObject(dragTaskGroup)
            .environmentObject(addExample)
            .font(.system(.body, design: .default))
            .onAppear {
                Appearance.applyTheme(appThemeSetting)
                self.isMainWindowOpen = true
            }
            .onDisappear {
                self.isMainWindowOpen = false
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
            // Change title bar color
            .onReceive(NotificationCenter.default.publisher(for: NSApplication.didFinishLaunchingNotification)) { _ in
                SideBarUtil.toggleSidebar()
                if let window = NSApp.windows.first {
                    window.titlebarAppearsTransparent = true
                    window.isMovableByWindowBackground = false
                    window.titlebarSeparatorStyle = .none
                    window.titleVisibility = .hidden
                    window.backgroundColor = NSColor(Color.App.listBackground)
                    //                    window.standardWindowButton(.closeButton)!.isHidden = true
                    //                    window.standardWindowButton(.miniaturizeButton)!.isHidden = true
                    //                    window.standardWindowButton(.zoomButton)!.isHidden = true
                }
            }
        }
        // already one inside notification
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
        .commands {
            MenuLine_File_NewWindow_Disable()
            
            // new menu option
            CommandGroup(before: .saveItem) {
                Button("Open Main Window") {
                    if (!self.isMainWindowOpen) {
                        self.openWindow(id: "MainWindow")
                    }
                }.disabled(self.isMainWindowOpen)
            }
            
            MenuLine_Help_SupportEmail()
            MenuLine_View_ToggleBoards()
            MenuLine_View_Appearance()
            MenuLine_Help_Examples()
            MenuLine_About()
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
        
        Self.logger.info("\(APP_NAME): \(APP_BUILD)/\(APP_DATA_VERSION)")
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
                primaryHidden.toggle()
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
    
    fileprivate func MenuLine_About() -> CommandGroup<Button<Text>> {
        CommandGroup(replacing: .appInfo, addition: {
            Button(action: {
                AppAbout.aboutWindow().makeKeyAndOrderFront(nil)
            }, label: {
                let aboutSuffix = NSLocalizedString("About", comment: "")
                Text("\(aboutSuffix)\u{00a0}\(Bundle.main.appName)")
            })
        })
    }

}

fileprivate func disallowTabbingMode() {
    NSWindow.allowsAutomaticWindowTabbing = false
}
