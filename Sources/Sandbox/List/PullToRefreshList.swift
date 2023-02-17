//
//  PullToRefreshList.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 31.01.2022.
//

import SwiftUI

struct PullToRefreshListView: View {
    @State var data = Array(0..<10)

    var body: some View {
        List {
            ForEach(data, id: \.self) { i in
                Text(i.description)
            }
        }
        .refreshable {
          await loadMore() // 1
        }
    }
    
    func loadMore() async {
        let request = URLRequest(url: URL(string: "https://httpbin.org/delay/2")!) // 2
        let _ = try! await URLSession.shared.data(for: request)
        data.append(contentsOf: Array(10..<20)) // 3
    }
}
