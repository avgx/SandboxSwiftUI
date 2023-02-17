//
//  NavBarEditMode.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 28.01.2022.
//

import SwiftUI

struct NavBarEditMode: View {
    @State var isEditMode: EditMode = .inactive
    
    @State var sampleData = ["苹果", "香蕉", "木瓜", "芒果"]
    
    var body: some View {
        NavigationView {
            List(0..<sampleData.count) { i in
                if (isEditMode == .active) {
                    TextField("水果", text: $sampleData[i])
                } else  {
                    Text(sampleData[i])
                }
            }
            .navigationTitle(Text("水果"))
            .navigationBarItems(leading: addButton, trailing: EditButton())            
            .environment(\.editMode, $isEditMode)
        }
    }
    
    private var addButton: some View {
        switch isEditMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }
    
    func onAdd() {
        // To be implemented in the next section
    }
}


#if DEBUG
@available(iOS 13.0, tvOS 14.0, *)
struct NavBarEditMode_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            NavBarEditMode()
            NavBarEditMode()
                .preferredColorScheme(.dark)
                .environment(\.editMode, .constant(.active))
        }
    }
}

#endif
