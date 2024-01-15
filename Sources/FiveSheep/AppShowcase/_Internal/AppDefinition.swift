#if canImport(SwiftUI) && canImport(StoreKit)

import Foundation
import StoreKit
import SwiftUI

struct AppDefinition: Identifiable, Decodable {
    let name: String
    let teaser: String
    let iconUrl: String
    let bundleId: String
    
    var id: String {
        bundleId
    }
}

extension AppDefinition {
    func presentStoreView() {
        let sKStoreProductViewController = SKStoreProductViewController()
        let parameters = [SKStoreProductParameterITunesItemIdentifier: bundleId]
        sKStoreProductViewController.loadProduct(withParameters: parameters)
        #if canImport(UIKit)
        (UIApplication.shared.connectedScenes.first as! UIWindowScene).windows.first?.rootViewController?.present(sKStoreProductViewController)
        #else
        // macOS TODO: This
        #endif
    }
}

#endif
