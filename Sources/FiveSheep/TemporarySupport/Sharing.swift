import Foundation
#if os(iOS)
import UIKit

public extension Hashable {
    
    /// Shares the responder using a `UIActivityViewController`.
    @available(iOSApplicationExtension, unavailable)
    @MainActor func share(applicationActivities: [UIActivity]? = nil, completion: (() -> Void)? = nil) {
        guard var viewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        
        while let next = viewController.presentedViewController, next != viewController {
            viewController = next
        }
        
        let controller: UIActivityViewController = UIActivityViewController(activityItems: [self], applicationActivities: applicationActivities)
        controller.modalPresentationStyle = .popover
        if let popoverController = controller.popoverPresentationController {
            popoverController.sourceView = viewController.view
            popoverController.sourceRect = viewController.view.bounds
            popoverController.permittedArrowDirections = []
        }
        viewController.present(controller, animated: true, completion: completion)
    }
}
#endif
