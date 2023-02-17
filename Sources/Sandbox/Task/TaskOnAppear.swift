//
//  TaskOnAppear.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 24.03.2022.
//

import SwiftUI

struct Course: Decodable {
    let name: String
    let imageUrl: URL
}

struct TaskOnAppearView: View {
    @State private var courses: [Course] = []

    var body: some View {
        NavigationView {
            List(courses, id: \.name) { course in
                HStack {
                    AsyncImage(url: course.imageUrl) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 120, height: 80)
                        
                    Text(course.name)
                }
            }
            .navigationTitle("Courses")
        }
        .task {
            do {
                guard let url = URL(
                    string: "https://swiftbook.ru//wp-content/uploads/api/api_courses"
                ) else { return }
                
                let (data, _) = try await URLSession.shared.data(from: url)
                courses = try JSONDecoder().decode([Course].self, from: data)
            } catch {
                courses = []
            }
        }
    }
}
