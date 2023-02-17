//
//  ColorPickerSample.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 21.12.2022.
//

import SwiftUI

struct ColorPickerSample: View {
    @State private var bgColor = Color.blue.opacity(0.5)
    
    var body: some View {
        VStack {
            ColorPicker("Choose a background color", selection: $bgColor)
                .padding(.horizontal)
            
            ColorPicker("Choose a background color",
                        selection: $bgColor,
                        supportsOpacity: false)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(bgColor)
        .ignoresSafeArea()
    }
}

struct ColorPickerSample2: View {
    @State private var shape1Color = Color.yellow
    @State private var shape2Color = Color.blue
    
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 120, height: 120)
                    .foregroundColor(shape1Color)
                    .padding(.horizontal)
                
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 120, height: 120)
                    .foregroundColor(shape2Color)
                    .padding(.horizontal)
            }
            
            Form {
                Section(header: Text("Color Settings")) {
                    ColorPicker("Shape 1 color", selection: $shape1Color)
                    ColorPicker("Shape 2 color", selection: $shape2Color)
                    
                    ColorPicker(selection: $shape2Color, label: {
                        Text("Change 🟦 color")
                            .font(.title)
                            .fontWeight(.bold)
                    })
                }
            }
            .frame(height: 150)
            .padding(.horizontal)
            .padding(.top, 50)
        }
    }
}
