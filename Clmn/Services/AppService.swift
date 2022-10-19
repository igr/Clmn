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
            return AppMetaData(appVersion: 0, dataVersion: 0)
        }
        let appMetaData: AppMetaData
        do {
            appMetaData = try Fridge.unfreeze🪅🎉(objId)
            Self.logger.notice("App meta-data fetched.")
        } catch {
            Self.logger.error("Failed to fetch app meta-data: \(error.localizedDescription)")
            fatalError("App meta-data failure!")
        }
        return appMetaData
    }

    func storeMetadata(appVersion: Int, dataVersion: Int) {
        let appMeta = AppMetaData(appVersion: appVersion, dataVersion: dataVersion)
        let objId = appObjectID()
        do {
            try Fridge.freeze🧊(appMeta, id: objId)
            Self.logger.notice("App meta-data stored.")
        } catch {
            Self.logger.error("Failed to store app meta-data: \(error.localizedDescription)")
        }
    }
    
}
