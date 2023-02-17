//
//  ListShows.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 04.04.2022.
//  https://github.com/atrinh0/listapp.ios/blob/main/7-swiftui-swift-playgrounds-4/ListApp.swiftpm/ContentView.swift

import SwiftUI

struct ListShowsView: View {
    @State var shows: [Show] = []
    @State var q: String = ""
    
    var body: some View {
        NavigationView {
            //            List(shows) { show in
            //                VStack(alignment: .leading) {
            //                    Text(show.name)
            //                    Text(show.subtitle)
            //                        .foregroundColor(.secondary)
            //                        .font(.caption)
            //                        .lineLimit(4)
            //                }
            //            }
            List {
                ForEach(shows) { show in
                    VStack(alignment: .leading) {
                        Text(show.name)
                        Text(show.subtitle)
                            .foregroundColor(.secondary)
                            .font(.caption)
                            .lineLimit(4)
                    }
                }
            }
            .listStyle(.grouped)
            .searchable(text: $q)
            .navigationBarTitle("1111", displayMode: .inline)
            .navigationBarHidden(false)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Total: \(shows.count)")
                }
                ToolbarItem(placement: .principal) { // <3>
                    VStack {
                        Text("SwiftUI").font(.headline)
                        Text("iOS 15").font(.subheadline)
                    }
                }
            })
            .task {
                await loadData()
            }
            .refreshable {
                await loadData()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    @MainActor
    func loadData() async {
        guard let url = URL(string: "https://api.tvmaze.com/shows"),
              let (data, _) = try? await URLSession.shared.data(for: URLRequest(url: url)),
              let shows = try? JSONDecoder().decode([Show].self, from: data) else { return }
        self.shows = shows
    }
}

struct Show: Codable, Identifiable {
    let id: Int
    let name, status, premiered, summary: String
    
    var subtitle: String {
        premiered + "\n" + status + summary
            .replacingOccurrences(of: "<p>", with: "\n")
            .replacingOccurrences(of: "</p>", with: "\n")
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
    }
}

