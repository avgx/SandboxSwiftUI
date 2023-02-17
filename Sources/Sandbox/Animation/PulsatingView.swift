//
//  PulsatingView.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 20.05.2022.
//

import SwiftUI

struct PulsatingView: View {

    let color = Color.orange
        
        @State var animate = false
        var body: some View {
            VStack {
                ZStack {
                    Circle().fill(color.opacity(0.25))
                        .frame(width: 40, height: 40).scaleEffect(self.animate ? 1 : 0)
                    Circle().fill(color.opacity(0.35))
                        .frame(width: 30, height: 30).scaleEffect(self.animate ? 1 : 0)
                    Circle().fill(color.opacity(0.45))
                        .frame(width: 15, height: 15).scaleEffect(self.animate ? 1 : 0)
                    Circle().fill(color)
                        .frame(width: 16.25, height: 16.25)
                }
                .onAppear { self.animate = true }
                .animation(animate ? Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default,
                           value: animate)
//                .onChange(of: viewModel.colorIndex) { _ in
//                    self.animate = false
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                        self.animate = true
//                    }
//                }
            }
        }
    }
