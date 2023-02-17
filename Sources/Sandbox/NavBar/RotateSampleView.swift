//
//  RotateSampleView.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 25.02.2022.
//

import Foundation

import SwiftUI

// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

struct RotateSampleView: View {
    
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        Group {
            if orientation.isPortrait {
                Text("Portrait")
            } else if orientation.isLandscape {
                Text("Landscape")
            } else if orientation.isFlat {
                Text("Flat")
            } else {
                Text("Unknown")
            }
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}


#if DEBUG
@available(iOS 13.0, tvOS 14.0, *)
struct RotateSampleView_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            RotateSampleView()
        }
    }
}

#endif

