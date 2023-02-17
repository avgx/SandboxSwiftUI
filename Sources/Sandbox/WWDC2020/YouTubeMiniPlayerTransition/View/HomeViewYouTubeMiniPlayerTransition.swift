//
//  HomeViewYouTubeMiniPlayerTransition.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI

struct HomeViewYouTubeMiniPlayerTransition: View {
    
    @StateObject var player = VideoPlayerViewModelYouTubeMiniPlayerTransition()
//    Gesture State to avoid Drag Gesture Gliches..
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView{
                VStack(spacing: 15){
                    ForEach(videosYouTubeMiniPlayerTransition){ video in
//                        video Card view...
                        CardViewYouTubeMiniPlayerTransition(video: video)
                            .onTapGesture {
                                withAnimation {
                                    player.showPlayer.toggle()
                                }
                            }
                    }
                }
            }
//            video player view...
            if player.showPlayer{
                MiniPlayerYouTubeMiniPlayerTransition()
//                move Form Bottom..
                    .transition(.move(edge: .bottom))
                    .offset(y: player.offset)
                    .gesture(DragGesture().updating($gestureOffset, body: { value, state, _ in
                        state = value.translation.height
                    })
                    .onEnded(onEnd(value:)))
            }
        }
        .onChange(of: gestureOffset) { newValue in
            onChanged()
        }
//        Setting Enviroment OBj..
        .environmentObject(player)
    }
    
    func onChanged(){
        
        if gestureOffset > 0 && !player.isMiniPlayer && player.offset + 70 <= player.height{
            player.offset = gestureOffset
        }
    }
    
    func onEnd(value: DragGesture.Value){
        withAnimation {
            if !player.isMiniPlayer{
                player.offset = 0
                //            closing view...
                if value.translation.height > UIScreen.main.bounds.height / 3{
                    player.isMiniPlayer = true
                }else{
                    player.isMiniPlayer = false
                }
            }
            
        }
        
    }
    
}

struct HomeViewYouTubeMiniPlayerTransition_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewYouTubeMiniPlayerTransition()
    }
}
