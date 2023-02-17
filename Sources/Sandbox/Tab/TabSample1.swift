//
//  TabSample1.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 24.05.2022.
//

import SwiftUI

struct ProductFeature {
    let title: String
    let image: String
}

extension ProductFeature: Identifiable {
    var id: String {
        return title
    }
}

extension ProductFeature: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


public struct TabSample1: View {
    
    static let data: [ProductFeature] = [
        ProductFeature(title: "Map", image: "globe"),
        ProductFeature(title: "Plan", image: "map"),
        ProductFeature(title: "Dashboards", image: "square.grid.3x3.fill"),
        ProductFeature(title: "Cameras", image: "video.fill"),
        ProductFeature(title: "All cameras", image: "video.fill.badge.ellipsis"),
        ProductFeature(title: "Actions", image: "bolt.fill"),
        ProductFeature(title: "Events", image: "rectangle.3.group.fill"),
        ProductFeature(title: "Alerts", image: "exclamationmark.triangle"),
        ProductFeature(title: "Face search", image: "person.crop.circle.badge.questionmark"),
        ProductFeature(title: "Lpr search", image: "car"),
        ProductFeature(title: "Persons", image: "person.text.rectangle"),
        ProductFeature(title: "Translation", image: "dot.radiowaves.left.and.right"),
        ProductFeature(title: "Audit", image: "lock.open.display"),
        ProductFeature(title: "Bookmarks", image: "bookmark"),
        ProductFeature(title: "Statistics", image: "chart.xyaxis.line")
    ]
    
    @State var data1: [ProductFeature] = Array(TabSample1.data.prefix(4))
    //    @State var data2: [ProductFeature] = Array(data.suffix(from: 4))
    
    @State var selected: String = ""
    
    public var profileView: some View {
        VStack {
            Text("Profile")
            Button(action: {
                data1 = Array(TabSample1.data.suffix(4))
            }) {
                Text("Change tabs")
            }
        }
    }
    
    public var body: some View {
        TabView(selection: $selected) {
            ForEach(data1) { item in
                NavigationView {
                    Text(item.title)
                        .navigationTitle(item.title)
                        .toolbar{
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button(action: {}) {
                                    Text("Button1")
                                }
                            }
                        }
                }
                .navigationViewStyle(.stack)
                .tabItem {
//                    Image(systemName: item.image)
//                    Text(item.title)
                    Label(item.title, systemImage: item.image)
                }.tag(item.title)
            }
            profileView.tabItem {
                Image(systemName: "person")
                Text("Profile")
            }.tag("Profile")
        }
    }
}
