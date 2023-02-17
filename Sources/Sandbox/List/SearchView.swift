//
//  SearchView.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 25.03.2022.
//  https://swiftwithmajid.com/2022/02/02/microapps-architecture-in-swift-dependency-injection/


import SwiftUI

public struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State private var query: String = ""

    public init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        List(viewModel.items, id: \.self) { item in
            Text(item)
        }
        .navigationTitle("Search")
        .searchable(text: $query) {
            ForEach(viewModel.recent, id: \.self) { query in
                Text(query)
                    .searchCompletion(query)
            }
        }
        .onSubmit(of: .search) {
            Task {
                await viewModel.search(matching: query)
            }
        }
        .task { await viewModel.fetchRecent() }
    }
}

@MainActor public final class SearchViewModel: ObservableObject {
    public struct Dependencies {
        var search: (String) async throws -> [String]
        var fetchRecent: () async throws -> [String]
    }

    let dependencies: Dependencies
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    @Published private(set) var items: [String] = []
    @Published private(set) var recent: [String] = []

    func fetchRecent() async {
        do {
            recent = try await dependencies.fetchRecent()
        } catch {
            recent = []
        }
    }

    func search(matching query: String) async {
        do {
            items = try await dependencies.search(query)
        } catch {
            items = []
        }
    }
}

extension SearchViewModel.Dependencies {
    static let mock: Self = .init(
        search: { _ in ["Search Item 1", "Search Item 2"] },
        fetchRecent: { ["query1", "query2"] }
    )
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView(
                viewModel: .init(
                    dependencies: .mock
                )
            )
        }
    }
}

struct SearchService {
    func search(matching query: String) async throws -> [String] {
        // ...
        return []
    }

    func fetchRecent() async throws -> [String] {
        // ...
        return []
    }

    func save(query: String) async throws {
        // ...
    }

    func delete(query: String) async throws {
        // ...
    }
}

struct AppDependencies {
    let searchService: SearchService
    //let storage: Storage
}

extension AppDependencies {
    var search: SearchViewModel.Dependencies {
        .init(
            search: searchService.search,
            fetchRecent: searchService.fetchRecent
        )
    }
}

struct RootView: View {
    let dependencies = AppDependencies(searchService: SearchService())

    var body: some View {
        SearchView(
            viewModel: .init(
                dependencies: dependencies.search
            )
        )
    }
}
