//
//  RectangleWithGrid.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 16.12.2022.
//

import SwiftUI

struct RectangleWithGrid: Shape {
    let stepX: Int
    let stepY: Int
    let selectionX: ClosedRange<Int>
    let selectionY: ClosedRange<Int>
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.width
        let h = rect.height
        
        let stepw = w / Double(stepX)
        let steph = h / Double(stepY)
        
        for i in 0...stepY {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY + CGFloat(i) * steph))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + CGFloat(i) * steph))
        }
        for j in 0...stepX {
            path.move(to: CGPoint(x: rect.minX + CGFloat(j) * stepw, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX + CGFloat(j) * stepw, y: rect.maxY))
        }
        
        return path
    }
}
