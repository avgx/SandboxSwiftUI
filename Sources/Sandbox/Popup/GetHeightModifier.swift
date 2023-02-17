//
//  GetHeightModifier.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 01.03.2022.
//  https://onmyway133.com/posts/how-to-get-view-height-in-swiftui/

import SwiftUI

struct GetHeightModifier: ViewModifier {
    @Binding var height: CGFloat

    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo -> Color in
                DispatchQueue.main.async {
                    height = geo.size.height
                }
                return Color.clear
            }
        )
    }
}

struct FilterView: View {
    @State private var height: CGFloat = 0

    var body: some View {
        //BottomSheet {
            NavigationView {
                VStack {
                    Text("content")
                    Text("content")
                    Text("content")
                    Text("content")
                    Spacer()
                    Button(action: { }) {
                        Text("Apply").foregroundColor(.white)
                    }
                    .background(.yellow)
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                }
                .background(.green)
                .navigationBarHidden(true)
                //.navigationTitle("navigationTitle")
                .navigationBarBackButtonHidden(true)
                .modifier(GetHeightModifier(height: $height))
            }
            .frame(height: height)
        //}
    }
}

struct FilterView2: View {
    var body: some View {
            
                VStack {
                    Text("Адрес доставки").font(.title)
                    Text("content")
                    Text("content")
                    Text("content")
                    Spacer()
                    Button(action: { }) {
//                        Text("Apply")
//                            //.padding(16)
//                            .foregroundColor(.white)
//                            .background(.yellow)
                            
                            
//                        Capsule()
//                            .fill(Color.accentColor)
//                            .frame(height: 50)
//                            .overlay(Text("Apply").font(.caption).foregroundColor(.white))
                        
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(height: 50)
                            .cornerRadius(8)
                            .overlay(Text("Apply").font(.title2).foregroundColor(.white))
//
//                        Text("Apply")
//                            .font(.caption)
//                            .foregroundColor(.white)
//                            //.padding(16)
//                            .background(.red)
//                            .frame(height: 50)
//                            .clipShape(Rectangle())
//                            .cornerRadius(8)
                    }
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 100)
//                    .clipShape(Rectangle())
//                    .cornerRadius(4)
                    .padding(.horizontal, 16)
//                    .background(.cyan)
                }
                //.background(.green)
            
    }
}
