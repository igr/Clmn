import SwiftUI

struct AboutView: View {
    private static var offSiteAdr: String {
        APP_SITE
    }
    private static var offEmail: String {
        APP_EMAIL
    }

    public static var offCiteUrl: URL {
        URL(string: AboutView.offSiteAdr)!
    }
    public static var offEmailUrl: URL {
        URL(string: "mailto:\(AboutView.offEmail)")!
    }

    var body: some View {
        VStack(spacing: 10) {
            Image(nsImage: NSImage(named: "AppIcon")!)

            Text("\(Bundle.main.appName)")
            .font(.system(size: 20, weight: .bold))
            .textSelection(.enabled)

            Link("\(AboutView.offSiteAdr.replacingOccurrences(of: "https://", with: ""))", destination: AboutView.offCiteUrl)

            Text("Ver: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild)) ")
            .textSelection(.enabled)

            Text(Bundle.main.copyright)
            .font(.system(size: 10, weight: .thin))
            .multilineTextAlignment(.center)
        }
        .padding(20)
        .frame(minWidth: 350, minHeight: 300)
    }
}
