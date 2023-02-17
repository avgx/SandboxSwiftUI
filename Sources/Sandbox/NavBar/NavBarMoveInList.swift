//
//  NavBarMoveInList.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 28.01.2022.
//

import SwiftUI

struct NavBarMoveInList: View {
    var body: some View {
        NavigationView{
            List {
                ForEach(
                    fruits,
                    id: \.self
                ) { fruit in
                    Text(fruit)
                }
                .onDelete { deleteFruit(at :$0) } //если закомментировать то кнопка удаления исчезнет
                .onMove { moveFruit(from: $0, to: $1) }
            }
            .navigationTitle("title")
            .toolbar {
                //                ToolbarItem(placement: .principal) { // <3>
                //                    Button(action: { }) {
                //                    HStack {
                //                        VStack(alignment: .center) {
                //                            Text("Site_1").font(.headline)
                //                            Text("Domain_1").font(.subheadline)
                //                        }
                //                        Image(systemName: "chevron.down").imageScale(.small)
                //                    }
                //                    //.background(.red)
                //                    .frame(maxWidth: .infinity, alignment: .center)
                //                    }
                //                }
                EditButton()
            }
        }
    }
    
    @State private var fruits = ["苹果", "香蕉", "木瓜", "芒果"]
    
    func deleteFruit(at offset: IndexSet) {
        fruits.remove(atOffsets: offset)
    }
    
    func moveFruit(from source: IndexSet, to destination: Int) {
        fruits.move(fromOffsets: source, toOffset: destination)
    }
}


#if DEBUG
@available(iOS 13.0, tvOS 14.0, *)
struct NavBarMoveInList_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            NavBarMoveInList()
            NavBarMoveInList()
                .preferredColorScheme(.dark)
            //.environment(\.colorScheme, .dark)
        }
    }
}

#endif
