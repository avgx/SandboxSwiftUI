//
//  GridAnimatedSample2.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 05.10.2022.
//

import Foundation
import SwiftUI

///
/// https://www.appcoda.com/learnswiftui/swiftui-gridlayout.html
///
struct GridAnimatedSample2: View {
    let samplePhotos = (1...20).map { Photo(name: "coffee-\($0)") }
    let level2 = (1...4).map({$0})
    
    @State var gridLayout = [ GridItem(.adaptive(minimum: 100)), GridItem(.flexible()) ]
    
    private var colors: [Color] = [.yellow, .purple, .green]
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
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
                            .frame(maxHeight: 150)
                            //.frame(height: gridLayout.count == 1 ? 200 : 100)
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)

                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                            ForEach(level2, id: \.self) { photo in
                                Image(systemName: "\(photo).circle")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .frame(height: 50)
                                    .cornerRadius(10)
                            }
                        }
                        .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
                        .animation(.easeIn, value: gridLayout.count)
                    }
                }
                .padding(.all, 10)
                .animation(.interactiveSpring(), value: gridLayout.count)
            }

            .navigationTitle("Coffee Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        //self.gridLayout = Array(repeating: .init(.flexible()), count: self.gridLayout.count % 4 + 1)
                    }) {
                        Image(systemName: "square.grid.2x2")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .onChange(of: verticalSizeClass) { value in
            self.gridLayout = [ GridItem(.adaptive(minimum:  verticalSizeClass == .compact  ? 100 : 250)), GridItem(.flexible()) ]
        }

    }
}
