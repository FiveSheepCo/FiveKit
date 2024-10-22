#if canImport(SwiftUI) && canImport(StoreKit)

import Foundation
import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
struct AppRow: View {
    enum Constants {
        static let cacheDirectory = SKDirectory.caches.directoryByAppending(path: "AppShowcase", createIfNonexistant: true)
    }
    
    private var model = AppShowcaseViewModel.shared
    
    @ScaledMetric private var titleFontSize: CGFloat = 14
    @ScaledMetric private var teaserFontSize: CGFloat = 12
    @ScaledMetric private var downloadSymbolSize: CGFloat = 22
    
    private let app: AppDefinition
    
    @State var loadedImage: UIImage?
    
    init(app: AppDefinition) {
        self.app = app
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            // App icon
            if let loadedImage {
                Image(uiImage: loadedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
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
        .onAppear {
            let imageStorageName = app.iconUrl.urlEncoded
            loadedImage = Constants.cacheDirectory.getData(at: imageStorageName).map({ UIImage(data: $0) }) ?? nil
            if loadedImage == nil, let url = URL(string: app.iconUrl) {
                Task {
                    do {
                        let (data, _) = try await URLSession.shared.data(from: url)
                        
                        Constants.cacheDirectory.save(data: data, at: imageStorageName)
                        
                        loadedImage = UIImage(data: data)
                    }
                    catch {
                        
                    }
                }
            }
        }
    }
}

@available(iOS 17.0, macOS 14.0, *)
#Preview {
    Form {
        AppRow(
            app: AppDefinition(
                name: "Preview App",
                teaser: "Lorem ipsum dolor sit amet consectetur adipiscing elit",
                iconUrl: "https://fivesheep.co/favicon.ico",
                bundleId: "co.fivesheep._preview",
                trackId: 12345
            )
        )
    }
}

#endif
