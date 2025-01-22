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
        
        let data: Data
        
        if let storedData = UserDefaults.standard.data(forKey: Constants.userDefaultsStorageKey), let date = UserDefaults.standard.object(forKey: Constants.userDefaultsDateStorageKey) as? Date {
            data = storedData
            
            if date.timeIntervalUntilNow > 30 * 86400 {
                Task {
                    try await refreshData()
                }
            }
        } else {
            data = try await refreshData()
        }
        
        // Decode response
        self.apps = try JSONDecoder().decode([AppDefinition].self, from: data).sorted(by: { a, b in
            a.name.compare(b.name) == .orderedAscending
        })
    }
    
    private func refreshData() async throws -> Data {
        // Build request
        var request = URLRequest(url: Constants.lookupUrl)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(Constants.baseBundleId, forHTTPHeaderField: "X-Bundle-Id")
        request.addValue(Constants.countryCode, forHTTPHeaderField: "X-Country-Code")
        
        // Await response
        let (data, _) = try await URLSession.shared.data(for: request)
        
        UserDefaults.standard.set(data, forKey: Constants.userDefaultsStorageKey)
        UserDefaults.standard.set(Date.now, forKey: Constants.userDefaultsDateStorageKey)
        
        return data
    }
}

@available(iOS 17.0, macOS 14.0, *)
extension AppShowcaseViewModel {
    enum Constants {
        static let lookupUrl = URL(string: "https://api.fivesheep.co/promotions.json")!
        static let countryCode = (Locale.current as NSLocale).countryCode ?? "US"
        static let userDefaultsStorageKey = "LoadedAppShowcase"
        static let userDefaultsDateStorageKey = "LoadedAppShowcase-Date"
        
        static var baseBundleId: String {
            Bundle.main.bundleIdentifier!
                .components(separatedBy: ".")
                .prefix(upTo: 3)
                .joined(separator: ".")
        }
    }
}

#endif
