//
//  HomeViewMultipleImageViewer.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 19/12/21.
//

import SwiftUI

struct HomeViewMultipleImageViewer: View {
    
    @StateObject var homeData = HomeViewModelMultipleImageViewer()
    
//    SwiftUI has bug in Page Tab Bar...
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        
        ScrollView{
            
//            Twitter View..
            HStack(alignment: .top, spacing: 15) {
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 10) {
                    
//                    In SwiftUI we can concatenate two or more Text's..
                    (
                        Text("Michele   ")
                            .fontWeight(.bold)
                        +
                        Text("@_Michele")
                            .foregroundColor(.gray)
                    )
                    
                    Text("#ios #swiftui #Michele")
                        .foregroundColor(.blue)
                    
                    Text("Michele nuove foto :((((")
                    
//                    Our Custom Grid of Items...
                    
//                    Since we having only two columns in a row..
//                    and max is 4 Grid Boxes...
                    let columns = Array(repeating: GridItem(.flexible(),spacing: 15), count: 2)
                 
                    LazyVGrid(columns: columns, alignment: .leading , spacing: 10) {
                        
                        ForEach(homeData.allImages.indices,id:\.self){ index in
                            
                            GridImageViewMultipleImageViewer(index: index)
                        }
                    }
                    .padding(.top)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .overlay(
            ZStack {
                if homeData.showImageViewer{
                    Color.black
                        .opacity(homeData.bgOpacity)
                        .ignoresSafeArea()
                    ImageViewMultipleImageViewer()
                }
            }
        )
//        setting environment Object..
        .environmentObject(homeData)
    }
}

struct HomeViewMultipleImageViewer_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewMultipleImageViewer()
    }
}
