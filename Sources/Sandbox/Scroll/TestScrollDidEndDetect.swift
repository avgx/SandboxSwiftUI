//
//  TestScrollDidEndDetect.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 20.05.2022.
//

import SwiftUI
import Combine

/// A preference key to store ScrollView offset
public struct ViewOffsetKey: PreferenceKey {
    public typealias Value = CGFloat
    public static var defaultValue = CGFloat.zero
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

/// https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestScrollDidEndDetect.swift
struct TestScrollDidEndDetect: View {
    var body: some View {
        ContentView()
    }

    struct ContentView: View {
        let detector: CurrentValueSubject<CGFloat, Never>
        let publisher: AnyPublisher<CGFloat, Never>

        init() {
            let detector = CurrentValueSubject<CGFloat, Never>(0)
            self.publisher = detector
                .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
                .dropFirst()
                .eraseToAnyPublisher()
            self.detector = detector
        }

        var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0...100, id: \.self) { i in
                        Rectangle()
                            .frame(width: 200, height: 100)
                            .foregroundColor(.green)
                            .overlay(Text("\(i)"))
                    }
                }
                .frame(maxWidth: .infinity)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewOffsetKey.self,
                                                  value: -$0.frame(in: .named("scroll")).origin.y)
                })
                .onPreferenceChange(ViewOffsetKey.self) { detector.send($0) }
            }
            .coordinateSpace(name: "scroll")
            .onReceive(publisher) {
                print("Stopped on: \($0)")
            }
        }
    }
}
