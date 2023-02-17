//
//  ListProfileSample.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 16.05.2022.
//

import SwiftUI

struct ListProfileSample: View {
    
    var body: some View {
        NavigationView {
        List {
            Section {
                HStack(spacing: 8) {
                    
                    Text("Имя пользователя")
                        .bold()
                        .lineLimit(1)
                        .scaledToFill()
                        .badge(Text("aqweqweqwe@werwersdfsdf.com"))
                        //.layoutPriority(100)
//                    Spacer()
//                    
//                        Text("aqweqweqwe@werwersdfsdf.com")
//                            .scaledToFill()
//                            .minimumScaleFactor(0.3)
//                            .lineLimit(1)
//                            .foregroundColor(.secondary)
//                            .font(.subheadline)
//                            .padding(.trailing, 16)
                    
                }
                
                
                Button(action: { }) {
                    Text("Switch")
                }
            }
        }
        }
    }
}
