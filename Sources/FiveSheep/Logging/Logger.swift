import OSLog

@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static func `for`<T>(_ type: T.Type) -> Logger {
        withCategory(String(describing: type))
    }
    
    static func withCategory(_ category: String) -> Logger {
        Logger(subsystem: subsystem, category: category)
    }
}
