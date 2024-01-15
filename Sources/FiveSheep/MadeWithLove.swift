#if canImport(SwiftUI)

import Foundation
import SwiftUI

public struct MadeWithLove: View {
    public init() {}
    
    public var body: some View {
        Section {
            EmptyView()
        } footer: {
            HStack {
                Spacer()
                VStack {
                    Text("Made with ❤️")
                    Image("fivesheep", bundle: .module)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                }
                Spacer()
            }
        }
        .onTapGesture {
            #if canImport(UIKit)
            UIApplication.shared.open(Constants.websiteUrl, completionHandler: { _ in })
            #elseif os(macOS)
            NSWorkspace.shared.open(Constants.websiteUrl)
            #endif
        }
    }
}

extension MadeWithLove {
    enum Constants {
        static let websiteUrl = URL(string: "https://fivesheep.co")!
    }
}

#Preview {
    Form {
        MadeWithLove()
    }
}

#endif
