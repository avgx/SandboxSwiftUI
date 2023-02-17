//
//  ListCanDeleteAllAndOffEditMode.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 19.05.2022.
//

import SwiftUI

struct ListCanDeleteAllAndOffEditMode: View {
    @Environment(\.editMode) var editMode
    @State private var users = ["Mary", "Mungo", "Midge"]

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    Text(user)
                }
                .onDelete(perform: delete)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: add) {
                        Label("Add", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .navigationTitle("Users")
        }
        .onChange(of: users) { newValue in
            if editMode?.wrappedValue == .active && users.count == 0 {
                editMode?.wrappedValue = .inactive
            }
        }
    }

    func add() {
        users.append("New User")
    }

    func delete(at offsets: IndexSet) {
        users.remove(atOffsets: offsets)
    }
}

struct ListCanDeleteAllAndOffEditMode2: View {
    // https://www.vadimbulavin.com/add-edit-move-and-drag-and-drop-in-swiftui-list/
    @State private var editMode = EditMode.inactive
    @State private var items = (0..<3).map { "Item #\($0)" }

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { user in
                    Text(user)
                }
                .onDelete(perform: delete)
                .onMove(perform: onMove)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { addButton }
                ToolbarItem(placement: .navigationBarTrailing) { editButton }
            }
            .navigationTitle("Users")
            .environment(\.editMode, $editMode)
            .onChange(of: items) { newValue in
                if editMode == .active && items.count == 0 {
                    editMode = .inactive
                }
            }
        }
    }

    private var editButton: some View {
        return Group {
            switch editMode {
            case .inactive:
                if items.count == 0 {
                    EmptyView()
                } else {
                    EditButton()
                }
            case .active:
                EditButton()
            default:
                EmptyView()
            }
        }
    }

    private var addButton: some View {
        return Group {
            switch editMode {
            case .inactive:
                Button(action: add) { Label("Add", systemImage: "plus") }
            default:
                EmptyView()
            }
        }
    }

    private func add() {
        items.append("New Item")
    }

    private func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    private func onMove(source: IndexSet, destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
}
