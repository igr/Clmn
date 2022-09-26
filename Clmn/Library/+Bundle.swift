import SwiftUI
import Foundation

extension Bundle {

    public var appName: String {
        g("CFBundleName")
    }
    public var displayName: String {
        g("CFBundleDisplayName")
    }
    public var language: String {
        g("CFBundleDevelopmentRegion")
    }
    public var identifier: String {
        g("CFBundleIdentifier")
    }
    public var copyright: String {
        g("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n")
    }

    public var appBuild: String {
        g("CFBundleVersion")
    }
    public var appVersionLong: String {
        g("CFBundleShortVersionString")
    }
    public var appVersionShort: String {
        g("CFBundleShortVersion")
    }

    fileprivate func g(_ str: String) -> String {
        infoDictionary?[str] as? String ?? "⚠️"
    }
}
