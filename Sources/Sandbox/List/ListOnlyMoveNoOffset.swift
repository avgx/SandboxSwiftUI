//
//  ListOnlyMoveNoOffset.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 19.05.2022.
//

import SwiftUI

struct ListOnlyMoveNoOffset: View  {
    
    /// this is the padding that the list adds in left for delete button when in the edit mode.
    /// I calculated the constant and works fine on iPhone11 but you will need to check for each device separately for accurate offset for every device.
    let listEditModeOffsetX = -UIScreen.main.bounds.width * 0.10647343
    
    @State var modelData: [String] = ["Eggs", "Milk", "Bread","Cake"]
    @State var editingList = false
    
    private func move(from source: IndexSet, to destination: Int) {
        modelData.move(fromOffsets: source, toOffset: destination)
        editingList = false
        print("On Move")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(modelData, id: \.self) { str in
                        Text(str)
                            .offset(x: self.editingList ? listEditModeOffsetX : 0)
                    }
                    .onMove(perform: self.move)
                    .onLongPressGesture{
                        self.editingList = true
                    }
                    
                }
                .environment(\.editMode, editingList ? .constant(.active):.constant(.inactive))
                .navigationBarTitle( Text("Test") )
            }
        }
    }
}
