//
//  DebounceSample1.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 22.12.2022.
//  https://github.com/Tunous/DebouncedOnChange

import Foundation
import SwiftUI
import DebouncedOnChange

struct DebounceSample1: View {
    @State private var text = ""

    var body: some View {
        TextField("Text", text: $text)
            .onChange(of: text, debounceTime: 2) { newValue in
                // Action executed each time 2 seconds pass since change of text property
            }
    }
}
