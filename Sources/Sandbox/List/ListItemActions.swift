//
//  ListItemActions.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 01.02.2022.
//

import SwiftUI

struct ListItemActions: View {
    
    var body: some View {
        
        List {
            Text("Pepperoni pizza")
                .swipeActions {
                    Button("Order") {
                        print("Awesome!")
                    }
                    .tint(.green)
                    Button("Burn") {
                        print("Right on!")
                    }
                    .tint(.red)
                }
            
            Text("Pepperoni with pineapple")
                .swipeActions {
                    Button("Burn") {
                        print("Right on!")
                    }
                    .tint(.red)
                }
            Text("Pepperoni with pineapple 2")
                .swipeActions(allowsFullSwipe: false) {
                    Button {
                        print("Muting conversation")
                    } label: {
                        Label("Mute", systemImage: "bell.slash.fill")
                    }
                    .tint(.indigo)
                    
                    Button(role: .destructive) {
                        print("Deleting conversation")
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                }
            Text("Pepperoni with pineapple 3")
                .swipeActions(edge: .leading) {
                    Button {
                        print("Add")
                    } label: {
                        Label("Add", systemImage: "plus.circle")
                    }
                    .tint(.indigo)
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        print("Subtract")
                    } label: {
                        Label("Subtract", systemImage: "minus.circle")
                    }
                }
        }
    }
    
}

