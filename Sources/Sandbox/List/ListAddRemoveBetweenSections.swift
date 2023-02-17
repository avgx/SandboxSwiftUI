//
//  ListAddRemoveBetweenSections.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 20.05.2022.
//

import SwiftUI

fileprivate let data: [ListAddRemoveBetweenSections.ServiceModel] = [
    ListAddRemoveBetweenSections.ServiceModel(image: "globe", title: "Map"),
    ListAddRemoveBetweenSections.ServiceModel(image: "map", title: "Plan"),
    ListAddRemoveBetweenSections.ServiceModel(image: "square.grid.3x3.fill", title: "Dashboards"),
    ListAddRemoveBetweenSections.ServiceModel(image: "video.fill", title: "Cameras"),
    ListAddRemoveBetweenSections.ServiceModel(image: "video.fill.badge.ellipsis", title: "All cameras"),
    ListAddRemoveBetweenSections.ServiceModel(image: "bolt.fill", title: "Actions"),
    ListAddRemoveBetweenSections.ServiceModel(image: "rectangle.3.group.fill", title: "Events"),
    ListAddRemoveBetweenSections.ServiceModel(image: "exclamationmark.triangle", title: "Alerts"),
    ListAddRemoveBetweenSections.ServiceModel(image: "person.crop.circle.badge.questionmark", title: "Face search"),
    ListAddRemoveBetweenSections.ServiceModel(image: "car", title: "Lpr search"),
    ListAddRemoveBetweenSections.ServiceModel(image: "person.text.rectangle", title: "Persons"),
    ListAddRemoveBetweenSections.ServiceModel(image: "dot.radiowaves.left.and.right", title: "Translation"),
    ListAddRemoveBetweenSections.ServiceModel(image: "lock.open.display", title: "Audit"),
    ListAddRemoveBetweenSections.ServiceModel(image: "bookmark", title: "Bookmarks"),
    ListAddRemoveBetweenSections.ServiceModel(image: "chart.xyaxis.line", title: "Statistics")
]

struct ListAddRemoveBetweenSections: View {
    struct ServiceModel: Identifiable {
        let image: String
        let title: String
        
        var id: String {
            return title
        }
    }
    
    struct ServiceItem: View {
        let title: String
        let imageName: String
        
        var body: some View {
            HStack {
                Image(systemName: imageName)
                Text(title)
                    .font(.system(.title3, design: .rounded))
                Spacer()
            }
        }
    }
    
    @State var data1: [ServiceModel] = Array(data.prefix(3))
    @State var data2: [ServiceModel] = Array(data.suffix(from: 4))
    @State private var editMode: EditMode = .inactive
    
    //    init() {
    //        self.data1 = Array(data.prefix(3))
    //        self.data2 = Array(data.suffix(from: 4))
    //        self.editMode = .inactive
    //    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Fast access")) {
                    ForEach(data1, id: \.id) { d in
                        HStack {
                            if editMode == .active && data1.count > 1 {
                                Image(systemName: "minus.circle.fill").foregroundColor(.red)
                                    .onTapGesture {
                                        withAnimation {
                                            self.move1to2(d)
                                        }
                                    }
                            }
                            ServiceItem(title: d.title, imageName: d.image).id(d.id)
                        }
                        //.listRowInsets(.init())
                        //.padding(.leading, editMode == .active ? -40 : 0)
                        .contentShape(Rectangle())
                    }
                    .onMove(perform: self.move1)
                }
                
                Section(header: Text(editMode == .active ? "Other" : "Services")) {
                    ForEach(data2, id: \.id) { d in
                        LazyHStack {
                            if editMode == .active && data1.count < 4 {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .onTapGesture {
                                        withAnimation {
                                            self.move2to1(d)
                                        }
                                    }
                            }
                            ServiceItem(title: d.title, imageName: d.image).id(d.id)
                        }
                        //.listRowInsets(EdgeInsets.init(top: 0, leading: -40, bottom: 0, trailing: 50))
//                        .border(Color.red, width: 1)
//                        .border(Color.purple)
//                        .contentShape(Rectangle())
//                        .border(Color.green)
//                        .onTapGesture {
//                            print("tap 1")
//                        }
                        //.allowsHitTesting(true)
                        //.padding(.leading, editMode == .active ? -40 : 0)
                        //.offset(x: editMode == .active ? -40 : 0)
                        //.listRowInsets(EdgeInsets(top: 0, leading: editMode == .active ? -40 : 0, bottom: 0, trailing: 50))
//                        .border(Color.red)
//                        .contentShape(Rectangle())
//                        .border(Color.gray)
//                        .onTapGesture {
//                            print("tap")
//                        }
                    }
                    .onMove(perform: self.move2)
                }
            }
            .navigationTitle("\(editMode == .active ? "Editing" : "Services")")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
        }
        .navigationViewStyle(.stack)
    }
    
    func move1to2(_ d: ServiceModel) {
        data1.removeAll(where: { $0.id == d.id })
        data2.insert(d, at: 0)
    }
    func move2to1(_ d: ServiceModel) {
        data2.removeAll(where: { $0.id == d.id })
        data1.append(d)
    }
    
    func delete1(at offsets: IndexSet) {
        data1.remove(atOffsets: offsets)
        print("On Delete1 \(offsets.first ?? 0)")
    }
    
    private func move1(from source: IndexSet, to destination: Int) {
        data1.move(fromOffsets: source, toOffset: destination)
        print("On Move1 \(source.first ?? 0) to \(destination)")
    }
    
    private func move2(from source: IndexSet, to destination: Int) {
        data2.move(fromOffsets: source, toOffset: destination)
        print("On Move2 \(source.first ?? 0) to \(destination)")
    }
}
