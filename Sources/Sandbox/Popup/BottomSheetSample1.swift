//
//  BottomSheetSample1.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 01.03.2022.
//  https://onmyway133.com/posts/how-to-make-bottom-sheet-in-swiftui/
//  https://swiftwithmajid.com/2019/12/11/building-bottom-sheet-in-swiftui/

import SwiftUI

struct BottomSheetSample1: View {
    @State private var showsBottomSheet: Bool = false

    var body: some View {
        VStack {
            Spacer()
            HStack{
                Spacer()
                Button(action: { showsBottomSheet = true }) {
                    Text("Show")
                }
                Spacer()
            }
            Spacer()
        }
        .bottomSheet1(isPresented: $showsBottomSheet) {
//            Text("Sheet content")
//                .frame(width: 200)
            FilterView()
        }
        .ignoresSafeArea(.all)
    }
}

extension View {
    func bottomSheet1<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .overlay(
                Group {
                    if isPresented.wrappedValue {
                        BottomSheet1(
                            isPresented: isPresented,
                            content: content
                        )
                    }
                }
            )
    }
}

extension Color {
    static let bottomSheetBackground = Color(hex: "363636")
    static let dropShadow = Color.red
}

private struct Distances {
    static let hidden: CGFloat = 500
    static let maxUp: CGFloat = -100
    static let dismiss: CGFloat = 200
}

struct BottomSheet1<Content: View>: View {
    @Binding var isPresented: Bool
    @ViewBuilder let content: Content

    @State private var translation = Distances.hidden

    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.5)

            VStack {
                Spacer()
                contentView
                    .offset(y: translation)
                    .animation(.interactiveSpring(), value: isPresented)
                    .animation(.interactiveSpring(), value: translation)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                guard translation > Distances.maxUp else { return }
                                translation = value.translation.height
                            }
                            .onEnded { value in
                                if value.translation.height > Distances.dismiss {
                                    translation = Distances.hidden
                                    isPresented = false
                                } else {
                                    translation = 0
                                }
                            }
                    )
            }
            .background(
                VStack {
                    Spacer()
                    Color.bottomSheetBackground
                        .frame(height: abs(Distances.maxUp) * 2)
                }
            )
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                translation = 0
            }
        }
    }

    private var contentView: some View {
        VStack(spacing: 0) {
            handle
                .padding(.top, 6)
            content
                .padding(20)
                .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity)
        .background(Color.bottomSheetBackground)
        .cornerRadius(24, corners: [.topLeft, .topRight])
        .shadow(color: Color.dropShadow, radius: 2, x: 0, y: -2)
    }

    private var handle: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(Color.gray)
            .frame(width: 48, height: 5)
    }
}
