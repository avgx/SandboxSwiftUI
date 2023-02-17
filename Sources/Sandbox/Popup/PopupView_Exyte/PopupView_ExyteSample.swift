//
//  PopupView_ExyteSample.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 09.12.2022.
//

import SwiftUI

struct ActionSheetSecond: View {
    var body: some View {
        ActionSheetView(bgColor: .white) {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 16) {
//                    Text("Privacy Policy")
//                        .font(.system(size: 24))
//
//                    Text(Constants.privacyPolicy)
//                        .font(.system(size: 14))
//                        .opacity(0.6)
//                }
//                .padding(.horizontal, 24)
//            }
            FilterView2()
        }
    }
}

struct PopupView_ExyteSample: View {
    @State private var isPresented = false

    var body: some View {
        VStack {
            Spacer()
            Button(action: { isPresented = true }) {
                Text("Show")
            }
            Spacer()
        }
        .ignoresSafeArea()
//        .popup(isPresented: $isPresented, type: .`default`, closeOnTap: false, backgroundColor: .black.opacity(0.4)) {
//            //PopupMiddle(isPresented: $popups.showingMiddle)
//            FilterView()
//        }
        .popup(isPresented: $isPresented, type: .toast, position: .bottom, closeOnTap: false, closeOnTapOutside: true, backgroundColor: .black.opacity(0.4)) {
            ActionSheetSecond()
        }
//        .popup(isPresented: $isPresented, type: .floater(), position: .bottom, closeOnTap: false, backgroundColor: .black.opacity(0.4)) {
//            //PopupBottomFirst(isPresented: $popups.showingBottomFirst)
//            FilterView()
//        }
//        .popup(isPresented: $isPresented, type: .floater(verticalPadding: 0, useSafeAreaInset: false), position: .bottom, closeOnTapOutside: true, backgroundColor: .black.opacity(0.4)) {
//            FilterView()
//        }
        
//        .popup(isPresented: $isPresented) {
////            Text("Sheet content")
////                .frame(width: 200)
//            FilterView()
//        }
    }
}

struct ActionSheetView<Content: View>: View {

    let content: Content
    let topPadding: CGFloat
    let fixedHeight: Bool
    let bgColor: Color

    init(topPadding: CGFloat = 100, fixedHeight: Bool = false, bgColor: Color = .white, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.topPadding = topPadding
        self.fixedHeight = fixedHeight
        self.bgColor = bgColor
    }

    var body: some View {
        ZStack {
            bgColor.cornerRadius(10, corners: [.topLeft, .topRight])
            VStack {
                Color.black
                    .opacity(0.2)
                    .frame(width: 40, height: 4)
                    .clipShape(Capsule())
                    .padding(.top, 10)
                    .padding(.bottom, 10)

                content
                    .padding(.bottom, 30)
                    .applyIf(fixedHeight) {
                        $0.frame(height: UIScreen.main.bounds.height - topPadding)
                    }
                    .applyIf(!fixedHeight) {
                        $0.frame(maxHeight: UIScreen.main.bounds.height - topPadding)
                    }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
