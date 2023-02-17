//
//  RectangleWithGridAndSelection.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 16.12.2022.
//

import SwiftUI

struct RectangleWithGridAndSelection: View {
    
    @Binding var selection: CGRect
    
    let selectionColor: Color
    let gridColor: Color
    
    let stepX = 16
    let stepY = 9
    
    
    private func updateSelection() {
        let x = Double(selectionX.lowerBound) / Double(stepX)
        let y = Double(selectionY.lowerBound) / Double(stepY)
        let w = Double(selectionX.upperBound - selectionX.lowerBound) / Double(stepX)
        let h = Double(selectionY.upperBound - selectionY.lowerBound) / Double(stepY)
        self.selection = CGRect(x: x, y: y, width: w, height: h)
    }
    
    @State var selectionX: ClosedRange<Int> = 3...6 {
        didSet {
            updateSelection()
        }
    }
    @State var selectionY: ClosedRange<Int> = 3...6 {
        didSet {
            updateSelection()
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            RectangleWithSelection(stepX: stepX, stepY: stepY, selectionX: selectionX, selectionY: selectionY)
                .foregroundColor(selectionColor.opacity(0.3))
                .allowsHitTesting(false)
            RectangleWithGrid(stepX: stepX, stepY: stepY, selectionX: selectionX, selectionY: selectionY)
                .stroke(gridColor, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                .gesture(
                    //fingerDrag
                    DragGesture()
                        .onChanged { value in
                            let x0 = Int(CGFloat(stepX) * value.startLocation.x / geometry.size.width)
                            let x1 = Int(CGFloat(stepX) * value.location.x / geometry.size.width) + 1
                            let y0 = Int(CGFloat(stepY) * value.startLocation.y / geometry.size.height)
                            let y1 = Int(CGFloat(stepY) * value.location.y / geometry.size.height) + 1
                            let rect = CGRect.init(x: min(x0, x1), y: min(y0, y1), width: abs(x1-x0), height: abs(y1-y0))
                            
                            let centerX = CGFloat(selectionX.upperBound + selectionX.lowerBound) / 2.0
                            let centerY = CGFloat(selectionY.upperBound + selectionY.lowerBound) / 2.0
                            let width = selectionX.upperBound - selectionX.lowerBound
                            let height = selectionY.upperBound - selectionY.lowerBound
                            
//                            print("onChanged \(rect) | \(centerX),\(centerY) | \(width)x\(height)")
                            self.selectionX = min(x0,x1)...max(x0,x1)
                            self.selectionY = min(y0, y1)...max(y0, y1)
                        }
//                        .onEnded { value in
//                            print("onEnded \(value.startLocation) \(value.location)")
//                        }
                )
        }
    }
}
