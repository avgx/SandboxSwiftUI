//
//  RectangleWithDrag.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 16.12.2022.
//

import SwiftUI

struct RectangleWithDrag: View {
    
    struct GetSizeModifier: ViewModifier {
        @Binding var width: CGFloat
        @Binding var height: CGFloat
        
        func body(content: Content) -> some View {
            content.background(
                GeometryReader { geo -> Color in
                    DispatchQueue.main.async {
                        width = geo.size.width
                        height = geo.size.height
                    }
                    return Color.clear
                }
            )
        }
    }
    
    struct Resizer: View {
        var body: some View {
            Rectangle()
            //.fill(Color.blue)
                .fill(Color.red.opacity(0.01))
                .frame(width: 32, height: 32)
        }
    }
    
    @Binding var selection: CGRect
    
    let delta = 16.0
    let color: Color
    
    @State private var width: CGFloat = 0
    @State private var height: CGFloat = 0
    
    private func updateSelection() {
        let x = location.x / width
        let y = location.y / height
        let w = size.width / width
        let h = size.height / height
        self.selection = CGRect(x: x, y: y, width: w, height: h)
    }
    @State private var topLeft:     CGPoint = CGPoint(x: 50, y: 50) {
        didSet {
            updateSelection()
        }
    }
    @State private var topRight:    CGPoint = CGPoint(x: 150, y: 50){
        didSet {
            updateSelection()
        }
    }
    @State private var bottomLeft:  CGPoint = CGPoint(x: 50, y: 150){
        didSet {
            updateSelection()
        }
    }
    @State private var bottomRight: CGPoint = CGPoint(x: 150, y: 150){
        didSet {
            updateSelection()
        }
    }
    
    
    var location: CGPoint {
        CGPoint(x: (bottomRight.x + topLeft.x) / 2, y: (bottomRight.y + topLeft.y)/2)
    }
    
    var size: CGSize {
        CGSize(width: bottomRight.x - topLeft.x, height: bottomRight.y - topLeft.y)
    }
    //    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil // 1
    
    @GestureState private var startSize: CGSize? = nil // 1
    
    @GestureState private var bottomRightLocation: CGPoint? = nil
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                
                let sz = startSize ?? size
                var newLocation = startLocation ?? location // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                
                //self.location = newLocation
                topLeft     = CGPoint(x: newLocation.x - sz.width / 2, y: newLocation.y - sz.height / 2)
                topRight    = CGPoint(x: newLocation.x + sz.width / 2, y: newLocation.y - sz.height / 2)
                bottomLeft  = CGPoint(x: newLocation.x - sz.width / 2, y: newLocation.y + sz.height / 2)
                bottomRight = CGPoint(x: newLocation.x + sz.width / 2, y: newLocation.y + sz.height / 2)
                
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location // 2
            }
            .updating($startSize) { (value, startSize, transaction) in
                startSize = startSize ?? size
            }
    }
    
    //    var fingerDrag: some Gesture {
    //        DragGesture()
    //            .updating($fingerLocation) { (value, fingerLocation, transaction) in
    //                fingerLocation = value.location
    //            }
    //    }
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(color.opacity(0.3))
                .frame(width: size.width, height: size.height)
                .position(location)
                .gesture(
                    simpleDrag//.simultaneously(with: fingerDrag)
                )
            RectangleCorners(delta: delta)
                .stroke(color, lineWidth: 4)
                .frame(width: size.width, height: size.height)
                .position(location)
                .allowsHitTesting(false)
            
            Resizer()
                .position(topLeft)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { value in
                            if value.location.x + delta < topRight.x && value.location.y + delta < bottomLeft.y {
                                topLeft = value.location
                                topRight = CGPoint(x: topRight.x, y: topLeft.y)
                                bottomLeft = CGPoint(x: topLeft.x, y: bottomLeft.y)
                            }
                        }
                )
            Resizer()
                .position(topRight)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { value in
                            if value.location.x - delta > topLeft.x && value.location.y + delta < bottomRight.y {
                                topRight = value.location
                                topLeft = CGPoint(x: topLeft.x, y: topRight.y)
                                bottomRight = CGPoint(x: topRight.x, y: bottomRight.y)
                            }
                        }
                )
            Resizer()
                .position(bottomLeft)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { value in
                            if value.location.x + delta < bottomRight.x && value.location.y - delta > topLeft.y {
                                bottomLeft = value.location
                                topLeft = CGPoint(x: bottomLeft.x, y: topLeft.y)
                                bottomRight = CGPoint(x: bottomRight.x, y: bottomLeft.y)
                            }
                        }
                )
            Resizer()
                .position(bottomRight)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { value in
                            if value.location.x - delta > bottomLeft.x && value.location.y - delta > topRight.y {
                                bottomRight = value.location
                                topRight = CGPoint(x: bottomRight.x, y: topRight.y)
                                bottomLeft = CGPoint(x: bottomLeft.x, y: bottomRight.y)
                            }
                        }
                )
            //            if let fingerLocation = fingerLocation {
            //                Circle()
            //                    .stroke(Color.green, lineWidth: 2)
            //                    .frame(width: 44, height: 44)
            //                    .position(fingerLocation)
            //            }
        }
        .modifier(GetSizeModifier(width: $width, height: $height))
        
    }
}
