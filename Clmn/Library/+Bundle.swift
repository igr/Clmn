import SwiftUI
import Foundation

extension Bundle {

    public var appName: String {
        i("CFBundleName")
    }
    public var displayName: String {
        i("CFBundleDisplayName")
    }
    public var language: String {
        i("CFBundleDevelopmentRegion")
    }
    public var identifier: String {
        i("CFBundleIdentifier")
    }
    public var copyright: String {
        i("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n")
    }

    public var appBuild: String {
        i("CFBundleVersion")
    }
    public var appVersionLong: String {
        i("CFBundleShortVersionString")
    }
    public var appVersionShort: String {
        i("CFBundleShortVersion")
    }

    fileprivate func i(_ str: String) -> String {
        infoDictionary?[str] as? String ?? "⚠️"
    }
}
