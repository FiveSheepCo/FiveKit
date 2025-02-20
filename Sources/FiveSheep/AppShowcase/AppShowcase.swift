#if canImport(SwiftUI) && canImport(StoreKit)

import Foundation
import SwiftUI

/// App showcase section for app cross-promotion.
///
/// Asynchronously loads recommended FiveSheep apps and displays them inside of a section.
///
/// - Note: If you're targeting iOS 16 or lower, use `SchafOffalKit` instead.
@available(iOS 17.0, macOS 14.0, *)
public struct AppShowcase<Content: View>: View {
    
    @Bindable
    private var model = AppShowcaseViewModel.shared
    
    private let header: () -> Content
    
    public init(@ViewBuilder header: @escaping () -> Content) {
        self.header = header

        Task { [self] in
            await model.setup()
        }
    }
    
    public var body: some View {
        if model.apps == nil || model.apps?.isEmpty == false {
            Section {
                if let apps = model.apps {
                    ForEach(apps) { app in
                        AppRow(app: app)
                    }
                } else {
                    ProgressView()
                }
            } header: {
                header()
            }
            .transition(.opacity.animation(.default))
        }
    }
}

@available(iOS 17.0, macOS 14.0, *)
#Preview {
    Form {
        AppShowcase {
            Text(verbatim: "Apps")
        }
    }
}

#endif
