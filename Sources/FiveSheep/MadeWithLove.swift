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
                    FiveSheepIcon(height: 40)
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
    
    struct FiveSheepIcon: View {
        let height: CGFloat
        
        var body: some View {
            let width = height * 1.35445
            let scaledWidth = width * 1.03921
            let scaledHeight = height
            FiveSheepShape()
                .frame(width: scaledWidth, height: scaledHeight)
                .offset(x: -width * 0.03921 * 1.5, y: -height * 0.05)
        }
    }
    
    struct FiveSheepShape: Shape {
        func path(in rect: CGRect) -> Path {
            let width = rect.size.width
            let height = rect.size.height
            var path = Path()
            path.move(to: CGPoint(x: 1.03921*width, y: 0.68476*height))
            path.addCurve(to: CGPoint(x: 1.01079*width, y: 0.87952*height), control1: CGPoint(x: 1.06658*width, y: 0.75733*height), control2: CGPoint(x: 1.05401*width, y: 0.827620*height))
            path.addCurve(to: CGPoint(x: 0.67362*width, y: 1.04762*height), control1: CGPoint(x: 0.93757*width, y: 0.96762*height), control2: CGPoint(x: 0.67362*width, y: 1.047620*height))
            path.addCurve(to: CGPoint(x: 0.93520*width, y: 0.86114*height), control1: CGPoint(x: 0.67362*width, y: 1.04762*height), control2: CGPoint(x: 0.88974*width, y: 0.898190*height))
            path.addCurve(to: CGPoint(x: 0.95816*width, y: 0.67581*height), control1: CGPoint(x: 0.99941*width, y: 0.80914*height), control2: CGPoint(x: 1.00579*width, y: 0.758190*height))
            path.addCurve(to: CGPoint(x: 0.57993*width, y: 0.24257*height), control1: CGPoint(x: 0.85862*width, y: 0.50371*height), control2: CGPoint(x: 0.69757*width, y: 0.312190*height))
            path.addCurve(to: CGPoint(x: 0.55263*width, y: 0.22743*height), control1: CGPoint(x: 0.57803*width, y: 0.24143*height), control2: CGPoint(x: 0.56026*width, y: 0.230670*height))
            path.addCurve(to: CGPoint(x: 0.49934*width, y: 0.20895*height), control1: CGPoint(x: 0.53531*width, y: 0.21886*height), control2: CGPoint(x: 0.51747*width, y: 0.212680*height))
            path.addCurve(to: CGPoint(x: 0.47586*width, y: 0.20533*height), control1: CGPoint(x: 0.49132*width, y: 0.20724*height), control2: CGPoint(x: 0.48349*width, y: 0.206190*height))
            path.addCurve(to: CGPoint(x: 0.20112*width, y: 0.46152*height), control1: CGPoint(x: 0.30178*width, y: 0.17952*height), control2: CGPoint(x: 0.22961*width, y: 0.348950*height))
            path.addCurve(to: CGPoint(x: 0.19158*width, y: 0.50467*height), control1: CGPoint(x: 0.19732*width, y: 0.47560*height), control2: CGPoint(x: 0.19413*width, y: 0.490010*height))
            path.addCurve(to: CGPoint(x: 0.18500*width, y: 0.55543*height), control1: CGPoint(x: 0.18818*width, y: 0.52121*height), control2: CGPoint(x: 0.18597*width, y: 0.538230*height))
            path.addCurve(to: CGPoint(x: 0.20079*width, y: 0.72133*height), control1: CGPoint(x: 0.18002*width, y: 0.61177*height), control2: CGPoint(x: 0.18547*width, y: 0.669040*height))
            path.addCurve(to: CGPoint(x: 0.40763*width, y: 0.90895*height), control1: CGPoint(x: 0.24026*width, y: 0.84933*height), control2: CGPoint(x: 0.31461*width, y: 0.905140*height))
            path.addCurve(to: CGPoint(x: 0.57132*width, y: 0.66267*height), control1: CGPoint(x: 0.51414*width, y: 0.91333*height), control2: CGPoint(x: 0.58447*width, y: 0.804000*height))
            path.addCurve(to: CGPoint(x: 0.42276*width, y: 0.49619*height), control1: CGPoint(x: 0.56132*width, y: 0.55648*height), control2: CGPoint(x: 0.48770*width, y: 0.478290*height))
            path.addCurve(to: CGPoint(x: 0.35526*width, y: 0.60952*height), control1: CGPoint(x: 0.38411*width, y: 0.50439*height), control2: CGPoint(x: 0.35518*width, y: 0.552960*height))
            path.addCurve(to: CGPoint(x: 0.43368*width, y: 0.72224*height), control1: CGPoint(x: 0.35557*width, y: 0.67150*height), control2: CGPoint(x: 0.39087*width, y: 0.722240*height))
            path.addCurve(to: CGPoint(x: 0.46428*width, y: 0.71324*height), control1: CGPoint(x: 0.44419*width, y: 0.72224*height), control2: CGPoint(x: 0.45460*width, y: 0.719170*height))
            path.addCurve(to: CGPoint(x: 0.38987*width, y: 0.74381*height), control1: CGPoint(x: 0.44191*width, y: 0.74381*height), control2: CGPoint(x: 0.41763*width, y: 0.750760*height))
            path.addCurve(to: CGPoint(x: 0.30849*width, y: 0.62714*height), control1: CGPoint(x: 0.34467*width, y: 0.73248*height), control2: CGPoint(x: 0.31743*width, y: 0.691050*height))
            path.addCurve(to: CGPoint(x: 0.43237*width, y: 0.39857*height), control1: CGPoint(x: 0.29263*width, y: 0.51448*height), control2: CGPoint(x: 0.34816*width, y: 0.413050*height))
            path.addCurve(to: CGPoint(x: 0.64125*width, y: 0.58238*height), control1: CGPoint(x: 0.52283*width, y: 0.38305*height), control2: CGPoint(x: 0.60572*width, y: 0.456190*height))
            path.addCurve(to: CGPoint(x: 0.57026*width, y: 0.96505*height), control1: CGPoint(x: 0.68007*width, y: 0.72038*height), control2: CGPoint(x: 0.65059*width, y: 0.879330*height))
            path.addCurve(to: CGPoint(x: 0.07092*width, y: 0.70857*height), control1: CGPoint(x: 0.39822*width, y: 1.14876*height), control2: CGPoint(x: 0.12355*width, y: 1.007900*height))
            path.addCurve(to: CGPoint(x: 0.51276*width, y: 0.06590*height), control1: CGPoint(x: 0.00401*width, y: 0.33038*height), control2: CGPoint(x: 0.24263*width, y: -0.01905*height))
            path.addCurve(to: CGPoint(x: 0.92875*width, y: 0.47648*height), control1: CGPoint(x: 0.69757*width, y: 0.12410*height), control2: CGPoint(x: 0.92875*width, y: 0.476480*height))
            path.addCurve(to: CGPoint(x: 1.03947*width, y: 0.68438*height), control1: CGPoint(x: 0.98250*width, y: 0.55857*height), control2: CGPoint(x: 1.01158*width, y: 0.610380*height))
            return path
        }
    }
}

#Preview {
    Form {
        MadeWithLove()
    }
}

#endif
