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

    /// Returns the build number.
    public var appBuild: String {
        i("CFBundleVersion")
    }
    /// Returns the public version number.
    public var appVersion: String {
        i("CFBundleShortVersionString")
    }

    fileprivate func i(_ str: String) -> String {
        infoDictionary?[str] as? String ?? "⚠️"
    }
}
