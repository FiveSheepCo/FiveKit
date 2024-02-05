#if canImport(SwiftUI) && canImport(StoreKit)

import Foundation
import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
struct AppRow: View {
    private var model = AppShowcaseViewModel.shared
    
    @ScaledMetric private var titleFontSize: CGFloat = 14
    @ScaledMetric private var teaserFontSize: CGFloat = 12
    @ScaledMetric private var downloadSymbolSize: CGFloat = 22
    
    private let app: AppDefinition
    
    init(app: AppDefinition) {
        self.app = app
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            // App icon
            AsyncImage(url: URL(string: app.iconUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
            }
            
            // Title and teaser
            VStack(alignment: .leading) {
                Text(app.name)
                    .font(.system(size: titleFontSize))
                Text(app.teaser)
                    .font(.system(size: teaserFontSize))
                    .opacity(0.75)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Download symbol
            Image(systemName: "icloud.and.arrow.down")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: downloadSymbolSize, height: downloadSymbolSize)
                .foregroundColor(.accentColor)
            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            app.presentStoreView()
        }
    }
}

#Preview {
    Form {
        if #available(iOS 17.0, macOS 14.0, *) {
            AppRow(
                app: AppDefinition(
                    name: "Preview App",
                    teaser: "Lorem ipsum dolor sit amet consectetur adipiscing elit",
                    iconUrl: "https://fivesheep.co/favicon.ico",
                    bundleId: "co.fivesheep._preview",
                    trackId: 12345
                )
            )
        } else {
            EmptyView()
        }
    }
}

#endif
