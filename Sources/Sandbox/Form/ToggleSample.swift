//
//  ToggleSample.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 13.12.2022.
//

import SwiftUI

struct ToggleSample: View {
    
    @State var isOn: Bool = false
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Label("toggle", systemImage: isOn ? "checkmark.square" : "square")
                .labelStyle(.titleAndIcon)
                .foregroundColor(.red)
        }
        .tint(.clear)
//                .foregroundColor(.clear)
//                .background(.clear)
//                .foregroundColor(.red)
//                .tint(.red)
        .toggleStyle(.button)
//                .toggleStyle(.switch)
        //.toggleStyle(MyToggleStyle())
    }
}

struct MyToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {}) {
            configuration.label
                .frame(width: 80, height: 50)
                .padding()
                .background(configuration.isOn ? .green : .white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
                .foregroundColor(configuration.isOn ? .white : .green)
        }
    }
}
