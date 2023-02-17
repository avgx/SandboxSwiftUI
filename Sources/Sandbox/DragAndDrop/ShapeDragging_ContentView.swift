//
//  ShapeDragging_ContentView.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 14.12.2022.
//  https://sarunw.com/posts/move-view-around-with-drag-gesture-in-swiftui/

import SwiftUI





struct ShapeDragging_ContentView: View {
    
    @State var figure1: CGRect = CGRect(x: 0.4, y: 0.4, width: 0.2, height: 0.2)
    @State var figure2: CGRect = CGRect(x: 0.4, y: 0.4, width: 0.2, height: 0.2)
    
    @State var isDrag: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
//                    Image("20221024T140623")
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: geometry.size.width * 9 / 16)
                        //.frame(width: geometry.size.width)
                    //            Triangle()
                    //                .stroke(.red, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                    //                .frame(width: 320, height: 320)
                    
                    //            RectangleWithGrid(stepX: 5, stepY: 10)
                    //                .stroke(.green, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                    //                .frame(maxWidth: .infinity)
                    //                .frame(maxHeight: .infinity)
                    //                //.frame(width: 300, height: 300)
                    //                //.foregroundColor(.red.opacity(0.3))
                    
                    if !isDrag {
                        RectangleWithGridAndSelection(selection: $figure1, selectionColor: .red, gridColor: .gray)
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: .infinity)
                            .onChange(of: figure1, perform: { r in
                                print("figure1 = \(r)")
                            })
                    } else {
                        RectangleWithDrag(selection: $figure2, color: .pink)
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: .infinity)
                            .onChange(of: figure2, perform: { r in
                                print("figure2 = \(r)")
                            })
                    }
                }
                .frame(height: geometry.size.width * 9 / 16)
                Spacer()
            }
            Toggle(isOn: $isDrag, label: {
                Text("drag")
            })
            Spacer()
        }
    }
}


