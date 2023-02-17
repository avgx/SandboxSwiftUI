//
//  TestViewModelTaskBlocking.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 20.05.2022.
//

import SwiftUI

struct TestViewModelTaskBlocking: View {
    var body: some View {
        ContentView()
    }

    class ViewModel: ObservableObject {
        @Published var items = [String]()
        func populate() async {
            Task.detached {
                var items = [String]()
                for i in 0 ..< 4_000_000 { /// this usually takes a couple seconds
                    items.append("\(i)")
                }
                await self.applyItems(items)
            }
        }

        @MainActor private func applyItems(_ items: [String]) {
            self.items = items
        }

        func reset() {
            self.items = []
        }
    }

    struct ContentView: View {
        @StateObject var model = ViewModel()
        @State var rotation = CGFloat(0)

        var body: some View {
            Button {
                model.reset()
                Task {
                    await model.populate()
                }
            } label: {
                Color.blue
                    .frame(width: 300, height: 80)
                    .overlay(
                        Text("\(model.items.count)")
                            .foregroundColor(.white)
                    )
                    .rotationEffect(.degrees(rotation))
            }
            .onAppear { /// should be a continuous rotation effect
                withAnimation(.easeInOut(duration: 2).repeatForever()) {
                    rotation = 90
                }
            }
        }
    }
}
