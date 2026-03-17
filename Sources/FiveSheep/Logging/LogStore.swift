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
            let predicate = NSPredicate(
                format: "subsystem == %@ AND eventType == %@",
                Bundle.main.bundleIdentifier!,
                "logEvent"
            )
            let logEvents: [OSLogEntry] = Array(try store.getEntries(at: position, matching: predicate))
            return logEvents
                .compactMap { $0 as? OSLogEntryLog }
                .map { "[\($0.date.formatted())] [\($0.category)] \($0.composedMessage)" }
        } catch {
            return []
        }
    }
}
