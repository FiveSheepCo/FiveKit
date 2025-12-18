import OSLog

@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension Logger {
    nonisolated(unsafe) private static var subsystem = Bundle.main.bundleIdentifier!

    @MainActor
    static func setup(bundleId: String) {
        Self.subsystem = bundleId
    }

    init<T>(type: T.Type) {
        self.init(subsystem: Self.subsystem, category: String(describing: type))
    }
    
    init(category: String) {
        self.init(subsystem: Self.subsystem, category: category)
    }
}
