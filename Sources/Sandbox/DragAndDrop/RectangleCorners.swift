//
//  RectangleCorners.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 16.12.2022.
//

import SwiftUI

struct RectangleCorners: Shape {
    let delta: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.width
        let h = rect.height
        
        // top left
        path.move(to: CGPoint(x: rect.minX + delta, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + delta))
        
        // top right
        path.move(to: CGPoint(x: rect.maxX - delta, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + delta))
        
        // bottom left
        path.move(to: CGPoint(x: rect.minX + delta, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - delta))
        
        // bottom right
        path.move(to: CGPoint(x: rect.maxX - delta, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - delta))
        
        return path
    }
}
