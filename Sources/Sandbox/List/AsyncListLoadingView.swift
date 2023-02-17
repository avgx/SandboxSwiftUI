//
//  AsyncListLoadingView.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 02.06.2022.
//

import SwiftUI

struct AsyncListLoadingView: View {
    
    //@StateObject var viewModel: ViewModel = ViewModel()
    @ObservedObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        TabView {
            body1nav.tabItem {
                Image(systemName: "person.fill")
                Text("View 1")
            }.tag("body1")
            Text("empty").tabItem {
                Image(systemName: "person")
                Text("Empty")
            }.tag("empty")
        }
    }
    var body1nav: some View {
        NavigationView {
            body1
        }
    }
    var body1: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView().foregroundColor(.accentColor)
            case .loaded(let domains):
                if domains.count > 0 {
                    NavigationLink(destination: {
                        ForEach(domains) { domain in
                            Text(domain.name)
                        }
                    }){
                        Text(domains.first!.name)
                    }
                } else {
                    Text("no domains")
                }
                
            case .error(let desc):
                Text(desc)
            case .idle:
                Text("idle")
            }
            
        }
        .task {
            await viewModel.load()
        }
    }
}

extension AsyncListLoadingView {
    class ViewModel: ObservableObject {
        enum State {
            case idle
            case loading
            case loaded([Show])
            //case empty(String)
            case error(String)
        }
        
        @Published var state: State = .idle {
            didSet {
                switch state {
                case .idle:
                    print("-> idle")
                case .loading:
                    print("-> loading")
                case .loaded(_):
                    print("-> loaded")
                    //case empty(String)
                case .error(_):
                    print("-> error")
                }
            }
        }
        
        @MainActor
        func load() async {
            do {
                state = .loading
                try await Task.sleep(nanoseconds: 1_000_000_000)
                let x = try await loadData()
                print(x.count)
                try await Task.sleep(nanoseconds: 1_000_000_000)
                state = .loaded(x)
            } catch {
                print("TODO: load domains error")
                state = .error(error.localizedDescription)
            }
        }
        
        func loadData() async throws -> [Show]  {
            let url = URL(string: "https://api.tvmaze.com/shows")!
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            let shows = try JSONDecoder().decode([Show].self, from: data)
            return shows
        }
    }
}
