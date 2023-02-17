//
//  RectangleWithSelection.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 16.12.2022.
//

import SwiftUI

struct RectangleWithSelection: View {
    let stepX: Int
    let stepY: Int
    let selectionX: ClosedRange<Int>
    let selectionY: ClosedRange<Int>
    
    var body: some View {
        GeometryReader { geometry in
            let centerX = CGFloat(selectionX.upperBound + selectionX.lowerBound) / 2.0
            let centerY = CGFloat(selectionY.upperBound + selectionY.lowerBound) / 2.0
            let width = selectionX.upperBound - selectionX.lowerBound
            let height = selectionY.upperBound - selectionY.lowerBound
            let cellX = geometry.size.width / CGFloat(stepX)
            let cellY = geometry.size.height / CGFloat(stepY)
            let x = CGFloat(centerX) * cellX
            let y = CGFloat(centerY) * cellY
            let w = CGFloat(width) * cellX
            let h = CGFloat(height) * cellY
            Rectangle()
                .position(CGPoint(x: x, y: y))
                .frame(width: w)
                .frame(height: h)
        }
    }
}
