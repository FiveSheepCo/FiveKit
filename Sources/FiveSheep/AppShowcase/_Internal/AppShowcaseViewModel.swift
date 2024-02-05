#if canImport(SwiftUI) && canImport(StoreKit)

import Foundation
import StoreKit

@MainActor
@Observable
@available(iOS 17.0, macOS 14.0, *)
class AppShowcaseViewModel {
    static let shared = AppShowcaseViewModel()
    
    private var setupStarted: Bool = false
    var apps: [AppDefinition]? = nil
    
    /// Load apps and keep retrying on failure unless task is cancelled.
    func setup(isRecursive: Bool = false) async {
        if setupStarted && !isRecursive { return }
        setupStarted = true
        
        do {
            try await loadApps()
        } catch {
            do {
                try await Task.sleep(for: .seconds(60))
                await self.setup(isRecursive: true)
            } catch {
                // Do nothing. Task was cancelled.
            }
        }
    }
    
    private func loadApps() async throws {
        
        // Build request
        var request = URLRequest(url: Constants.lookupUrl)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(Constants.baseBundleId, forHTTPHeaderField: "X-Bundle-Id")
        request.addValue(Constants.countryCode, forHTTPHeaderField: "X-Country-Code")

        // Await response
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Decode response
        self.apps = try JSONDecoder().decode([AppDefinition].self, from: data).sorted(by: { a, b in
            a.name.compare(b.name) == .orderedAscending
        })
    }
}

@available(iOS 17.0, macOS 14.0, *)
extension AppShowcaseViewModel {
    enum Constants {
        static let lookupUrl = URL(string: "https://fivesheep.co/api/promotions.json")!
        static let countryCode = (Locale.current as NSLocale).countryCode ?? "US"
        
        static var baseBundleId: String {
            Bundle.main.bundleIdentifier!
                .components(separatedBy: ".")
                .prefix(upTo: 3)
                .joined(separator: ".")
        }
    }
}

#endif
