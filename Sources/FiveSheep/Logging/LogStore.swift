import OSLog

@available(macOS 12, iOS 16, tvOS 16, watchOS 9, *)
final class LogStore {
    private init() {}
    
    static func export() async -> [String] {
        let calendar = Calendar.current
        let oneWeekAgo = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -3, to: .now)!)
        do {
            let store = try OSLogStore(scope: .currentProcessIdentifier)
            let position = store.position(date: oneWeekAgo)
            return try await store
                .getEntries(at: position)
                .compactMap { $0 as? OSLogEntryLog }
                .asyncFilter { $0.subsystem == Bundle.main.bundleIdentifier! }
                .asyncMap { "[\($0.date.formatted())] [\($0.category)] \($0.composedMessage)" }
        } catch {
            return []
        }
    }
}
