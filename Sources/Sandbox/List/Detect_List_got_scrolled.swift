//
//  Detect_List_got_scrolled.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 20.05.2022.
//

import SwiftUI

struct Detect_List_got_scrolled: View {
    @State private var users = ["Mary", "Mungo", "Midge","Mary", "Mungo", "Midge","Mary", "Mungo", "Midge"]

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    Text(user)
                }
            }
            .simultaneousGesture(DragGesture().onChanged({ _ in
                // if keyboard is opened then hide it
                print("simultaneousGesture")
            }))
        }
    }
}
