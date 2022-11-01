import SwiftUI
import Cocoa

struct AppAbout {
    static let windowWidth: CGFloat = 388.0
    static let windowHeight: CGFloat = 268.0

    static func aboutWindow(for bundle: Bundle = Bundle.main) -> NSWindow {
        let origin = CGPoint.zero
        let size = CGSize(width: windowWidth, height: windowHeight)

        let window = NSWindow(contentRect: NSRect(origin: origin, size: size),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false)

        window.setFrameAutosaveName(bundle.appName)
        window.setAccessibilityTitle(bundle.appName)
        window.titlebarAppearsTransparent = true
        window.isMovableByWindowBackground = true
        window.isReleasedWhenClosed = false

        let aboutView = AppAboutView(bundle: bundle,
            appIconBackside: Image("AppBW"),
            creditsURL: "https://clmnapp.com")

        window.contentView = NSHostingView(rootView: aboutView)
        window.center()

        return window
    }
}

/// MARK: - About View
fileprivate struct AppAboutView: View {
    let bundle: Bundle
    var appIconBackside: Image? = nil // 128pt × 128pt
    var creditsURL: String? = nil

    private let windowWidth: CGFloat = AppAbout.windowWidth
    private let windowHeight: CGFloat = AppAbout.windowHeight

    @State private var iconHover: Bool = false
    @State private var foregroundIconVisible: Bool = true
    @State private var backgroundIconVisible: Bool = false

    var body: some View {
        VStack(spacing: .zero) {
            HStack {

                appIcon

                VStack(spacing: .zero) {
                    Spacer()

                    appName

                    Spacer()

                    appLongText

                    // Credits
                    Group {
                        if let creditsURLString = creditsURL {
                            Button(action: {
                                if let url = URL(string: creditsURLString) {
                                    NSWorkspace.shared.open(url)
                                }
                            }, label: {
                                Text("Visit Website", bundle: bundle)
                                .lineLimit(1)
                            })
                            .buttonStyle(AppAboutWindowButtonStyle())
                        }
                    }
                    .padding([.top], 20.0)
                    .padding([.bottom], 8.0)

                    Spacer()
                    Divider()
                    .padding([.top], 16.0)
                }
                .frame(width: windowWidth, height: windowHeight)
            }

            bottomLine
        }
    }

    private var appLongText: some View {
        HStack {
            Text("Clmn is a beautiful task board native app for macOS. It is thoughtfully simple and unbearably efficient; nothing fancy, just enough. " +
                "Clmn is designed for professionals that work mostly on laptops.")
        }
        .padding()
    }

    private var appName: some View {
        VStack(spacing: .zero) {
            // App Name
            Text(bundle.appName)
            .font(Font.title.weight(.semibold))
            .padding([.bottom], 6.0)

            // App Version & Build
            HStack(spacing: 4.0) {
                Text("Version\u{00a0}\(bundle.appVersion)")
                .font(Font.body.weight(.medium))
                .foregroundColor(.secondary)

                Text("(\(bundle.appBuild))")
                .font(Font.body.monospacedDigit().weight(.regular))
                .foregroundColor(.secondary)
                .opacity(0.7)
            }
        }
    }

    private var bottomLine: some View {
        HStack(spacing: .zero) {
            Spacer()
            Text("Coded with ❤️ and some 🌤️")
            Spacer()
        }
        .font(Font.footnote)
        .foregroundColor(.secondary)
        .opacity(0.7)
        .help("zzzz")
        .padding([.top], 12.0)
        .padding([.bottom], 14.0)
        .background(Color.primary.opacity(0.03))
    }

    private var appIcon: some View {
        ZStack {
            // App Icon: Back
            Group {
                if let backside = appIconBackside {
                    backside.resizable()
                } else {
                    AppIconPlaceholder()
                }
            }
            .rotation3DEffect(backgroundIconVisible ? Angle.zero : Angle(degrees: -90.0),
                axis: (x: 0.0, y: 1.0, z: 0.0),
                anchor: .center,
                anchorZ: 0.0,
                perspective: -0.5)

            // App Icon: Front
            Group {
                if let appIcon = NSApp.applicationIconImage {
                    Image(nsImage: appIcon)
                } else {
                    AppIconPlaceholder()
                }
            }
            .rotation3DEffect(foregroundIconVisible ? Angle.zero : Angle(degrees: 90.0),
                axis: (x: 0.0, y: 1.0, z: 0.0),
                anchor: .center,
                anchorZ: 0.0,
                perspective: -0.5)

        }
        .frame(width: 128.0, height: 128.0)
        .brightness(iconHover ? 0.05 : 0.0)
        .padding([.bottom], 14.0)
        .padding([.trailing], 14.0)
        .onHover(perform: { state in
            let ani = Animation.easeInOut(duration: 0.16)
            withAnimation(ani, {
                self.iconHover = state
            })

            if !state && backgroundIconVisible {
                flipIcon()
            }
        })
        .onTapGesture(perform: {
            flipIcon()
        })
    }

    private func flipIcon() {
        let reversed = foregroundIconVisible
        let inDuration = 0.12
        let inAnimation = Animation.easeIn(duration: inDuration)
        let outAnimation = Animation.easeOut(duration: 0.32)

        withAnimation(inAnimation, {
            if reversed {
                self.foregroundIconVisible.toggle()
            } else {
                self.backgroundIconVisible.toggle()
            }
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + inDuration) {
            withAnimation(outAnimation, {
                if !reversed {
                    self.foregroundIconVisible.toggle()
                } else {
                    self.backgroundIconVisible.toggle()
                }
            })
        }
    }
}

fileprivate struct AppIconPlaceholder: View {
    private let cornerSize: CGSize = CGSize(width: 24.0, height: 24.0)
    var body: some View {
        RoundedRectangle(cornerSize: cornerSize, style: .continuous)
        .foregroundColor(Color.secondary)
        .padding(13.0)
    }
}

fileprivate struct AppAboutWindowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let color = Color.accentColor
        let pressed = configuration.isPressed
        return configuration.label
        .font(Font.body.weight(.medium))
        .padding([.leading, .trailing], 8.0)
        .padding([.top], 4.0)
        .padding([.bottom], 5.0)
        .background(color.opacity(pressed ? 0.08 : 0.14))
        .foregroundColor(color.opacity(pressed ? 0.8 : 1.0))
        .cornerRadius(5.0)
    }
}
