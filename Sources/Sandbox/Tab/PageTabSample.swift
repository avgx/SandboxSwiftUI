//
//  PageTabSample.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 24.05.2022.
//

import SwiftUI

struct PageTabSample: View {
    
    var body: some View {
        GeometryReader { geo in
            TabView{
                ForEach(0..<50) { index in
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color(.sRGB, red: Double.random(in: 0..<1), green: Double.random(in: 0..<1), blue: Double.random(in: 0..<1), opacity: 1))
                        // Setting own color
                        Image(systemName: "\(index).circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width - 30, height: geo.size.height - 260, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    }
                    .cornerRadius(20)
                    .frame(width: geo.size.width - 50, height: geo.size.height - 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }.background(Color.orange)
            }
            .padding(.bottom) // TabviewStyle let  style tab view
            // PageTabViewStyle  lets creaste featurte view
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            // Lets have background for slider in feature view show even with white background
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

