//
//  BottomSheetSample3.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 01.03.2022.
//

import SwiftUI

struct BottomSheetSample3: View {
    @State private var isPresented = false

    var body: some View {
        VStack {
            
            Button(action: { isPresented = true }) {
                Text("Show")
            }
        }
        .bottomSheet(isPresented: $isPresented) {
//            Text("Sheet content")
//                .frame(width: 200)
            FilterView()
        }
//        .bottomSheet(
//            isPresented: $isPresented,
//            detents: [.medium(), .large()],
//            largestUndimmedDetentIdentifier: .large,
//            prefersGrabberVisible: true,
//            prefersScrollingExpandsWhenScrolledToEdge: true,
//            prefersEdgeAttachedInCompactHeight: false,
//            widthFollowsPreferredContentSizeWhenEdgeAttached: false,
//            onDismiss: { print("Dismissed") }
//        ) {
//            //Text("Hello, world!")
//            FilterView()
//        }
    }
}
