import os
import Foundation
import Fridge

class AppService {

    private func appObjectID() -> String {
        "clmn.app"
    }

    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: AppService.self)
    )

    func fetchMetadata() -> AppMetaData {
        let objId = appObjectID()
        if (!Fridge.isFrozen🔬(objId)) {
            let newAppMetaData = AppMetaData(appVersion: APP_VERSION, dataVersion: APP_DATA_VERSION)
            storeMetadata(newAppMetaData)
        }
        let appMetaData: AppMetaData
        do {
            appMetaData = try Fridge.unfreeze🪅🎉(objId)
            Self.logger.notice("App meta-data fetched.")
        } catch {
            Self.logger.error("Failed to fetch app meta-data: \(error._code)")
            fatalError("App meta-data missing!")
        }
        return appMetaData
    }

    func storeMetadata(_ appMeta: AppMetaData) {
        let objId = appObjectID()
        do {
            try Fridge.freeze🧊(appMeta, id: objId)
            Self.logger.notice("App meta-data stored.")
        } catch {
            Self.logger.error("Failed to store app meta-data: \(error._code)")
        }
    }
}
