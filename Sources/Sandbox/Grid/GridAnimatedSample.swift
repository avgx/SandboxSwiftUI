//
//  GridAnimatedSample.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 05.10.2022.
//

import Foundation
import SwiftUI

///
/// https://www.appcoda.com/learnswiftui/swiftui-gridlayout.html
///
struct GridAnimatedSample: View {
    let samplePhotos = (1...20).map { Photo(name: "coffee-\($0)") }
    
    @State var gridLayout: [GridItem] = [ GridItem() ]
    private var colors: [Color] = [.yellow, .purple, .green]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {

                    ForEach(samplePhotos.indices) { index in

                        //Image(samplePhotos[index].name)
                        Image(systemName: "\(index).circle")
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(colors[index % colors.count])
                            //.frame(height: 200)
                            .frame(height: gridLayout.count == 1 ? 200 : 100)
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)

                    }
                }
                .padding(.all, 10)
                .animation(.interactiveSpring(), value: gridLayout.count)
            }

            .navigationTitle("Coffee Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.gridLayout = Array(repeating: .init(.flexible()), count: self.gridLayout.count % 4 + 1)
                    }) {
                        Image(systemName: "square.grid.2x2")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
            }
        }

    }
}

struct Photo: Identifiable {
    var id = UUID()
    var name: String
}



struct GridAnimatedSample1: View {
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]

    private var colors: [Color] = [.yellow, .purple, .green]

    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                ForEach((0...9999), id: \.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                        .frame(width: 50, height: 50)
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
    }
    
}
