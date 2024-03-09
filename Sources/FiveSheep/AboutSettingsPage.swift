import Foundation
import SwiftUI

#if os(iOS)
@available(iOS 16, *)
public struct AboutSettingsPage: View {
    @State private var isExportingLogs: Bool = false
    @State private var exportedLogString: String? = nil
    
    private func export(completion: (() -> Void)? = nil) {
        if let exportedLogString {
            let filename = "\(Bundle.main.identifier).log"
            let directory = SKDirectory.caches
            directory.save(data: exportedLogString.data(using: .utf8)!, at: filename)
            
            let url = directory.url.appendingPathComponent(filename)
            url.share(completion: completion)
        } else {
            isExportingLogs = true
            
            Task { @MainActor in
                exportedLogString = await Task.detached {
                    await LogStore.export().joined(separator: "\n")
                }.value
                
                export {
                    isExportingLogs = false
                    completion?()
                }
            }
        }
    }
    
    public init() {}
    
    public var body: some View {
        Form {
            Section {
                HStack {
                    Text("settings.about.version", bundle: .module, comment: "Version number and build of the app")
                    Spacer()
                    Text(verbatim: "\(Bundle.main.appVersionString) (Build \(Bundle.main.appBuild))")
                }
            }
            
            Section {
                if isExportingLogs {
                    HStack {
                        Text("settings.about.gatheringLogs", bundle: .module)
                            .foregroundStyle(Color.gray)
                        Spacer()
                        ProgressView()
                            .tint(Color.gray)
                    }
                } else {
                    Button { export() } label: {
                        Text("settings.about.btn.exportLogs", bundle: .module)
                    }
                }
            } footer: {
                Text("settings.about.section.logs.footer", bundle: .module, comment: "Footer of the about section for diagnostic purposes")
            }
        }
    }
}
#endif

public extension Bundle {
    var appName: String           { getInfo("CFBundleName") }
    var displayName: String       { getInfo("CFBundleDisplayName") }
    var language: String          { getInfo("CFBundleDevelopmentRegion") }
    var identifier: String        { getInfo("CFBundleIdentifier") }
    var copyright: String         { getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n") }
    
    var appBuild: String          { getInfo("CFBundleVersion") }
    var appVersionString: String    { getInfo("CFBundleShortVersionString") }
    
    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}
