//
//  TodayAppStoreAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 01/12/21.
//

import SwiftUI

struct TodayAppStoreAnimations: View {
    var animation : Namespace.ID
    @EnvironmentObject var detail: DetailViewModelAppStoreAnimations
    
    var body: some View {
        ScrollView{
            VStack{
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Thuesday 2 December")
                            .foregroundColor(.gray)
                        Text("Today")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "person.circle")
                            .font(.largeTitle)
                    }
                }
                .padding()
                
                ForEach(itemsAppStoreAnimation) { item in
//                    Card View...
                    TodayCardViewAppStoreAnimations(item: item,animation: animation)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)){
                                detail.selectedItem = item
                                detail.show.toggle()
                            }
                        }
                }
            }
            .padding(.bottom )
        }
        .background(Color.primary.opacity(0.06).ignoresSafeArea())
    }
}

//Hero Animation...
