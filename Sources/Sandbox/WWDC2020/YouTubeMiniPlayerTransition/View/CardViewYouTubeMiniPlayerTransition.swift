//
//  CardViewYouTubeMiniPlayerTransition.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI

struct CardViewYouTubeMiniPlayerTransition: View {
    var video: videoYouTubeMiniPlayerTransition
    var body: some View {
        VStack(spacing: 10){
            Image(video.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
            
            HStack(spacing: 15){
                Image("g1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(video.title)
                        .fontWeight(.semibold)
                        .font(.callout)
                    
                    HStack{
                        Text("Kavasoft")
                            .fontWeight(.bold)
                            .font(.caption)
                        
                        Text(".12K Views.5 Days Ago")
                            .font(.caption)
                    }
                    .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal)
    }
}

struct CardViewYouTubeMiniPlayerTransition_Previews: PreviewProvider {
    static var previews: some View {
       HomeViewYouTubeMiniPlayerTransition()
    }
}
