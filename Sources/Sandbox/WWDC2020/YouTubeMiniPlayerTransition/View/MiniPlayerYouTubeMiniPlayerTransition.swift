//
//  MiniPlayerYouTubeMiniPlayerTransition.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI

struct MiniPlayerYouTubeMiniPlayerTransition: View {
    
//    Screen Height..

    @EnvironmentObject var player: VideoPlayerViewModelYouTubeMiniPlayerTransition
    var body: some View {
        VStack(spacing: 0){
//            video player..
            HStack{
                VideoPlayerViewYouTubeMiniPlayerTransition()
                    .frame(width: player.isMiniPlayer ? 150 : player.width,height: player.isMiniPlayer ? 70 : getFrame())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
//                controls...
                VideoControls()
            )
            GeometryReader{reader in
                ScrollView {
                    VStack(spacing: 18){
    //                    video Playback Details And buttons...
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Transformazione figa di gente simpatica")
                                .font(.callout)
                            
                            Text("1.2M Views")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
    //                    buttons..
                        HStack{
                            PlayBackVideoButtons(image: "hand.thumbsup", text: "123K")
                            
                            PlayBackVideoButtons(image: "hand.thumbsdown", text: "1K")
                            
                            PlayBackVideoButtons(image: "hand.thumbsup", text: "123K")
                            
                            PlayBackVideoButtons(image: "square.and.arrow.down", text: "Share")
                            
                            PlayBackVideoButtons(image: "square.and.arrow.down", text: "Download")
                            
                            PlayBackVideoButtons(image: "message", text: "Live Chat")

                        }
                        
                        Divider()
                        
                        VStack(spacing: 15){
                            ForEach(videosYouTubeMiniPlayerTransition){ video in
        //                        video Card view...
                                CardViewYouTubeMiniPlayerTransition(video: video)
                            }
                        }
                        
                    }
                    .padding()
                }
                .onAppear {
                    player.height = reader.frame(in: .global).height + 250
                }
            }
            .background(Color.white)
            .opacity(player.isMiniPlayer ? 0 : getOpacity())
            .frame(height: player.isMiniPlayer ? 0 : nil)
        }
        .background(
            Color.white
                .ignoresSafeArea(.all,edges: .all)
                .onTapGesture {
                    withAnimation {
                        player.width = UIScreen.main.bounds.width
                        player.isMiniPlayer.toggle()
                    }
                }
        )
    }
    
//    Getting Frame And Opacity While Dragging..
    
    func getFrame()->CGFloat{
        let progress = player.offset / (player.height - 100)
        
        if (1-progress) <= 1.0{
            let videoHeight : CGFloat = (1 - progress) * 250
            
            if videoHeight <= 70{
                
//             decresing Width..
                let percent = videoHeight / 70
                let videoWidth : CGFloat = percent * UIScreen.main.bounds.width
                
                DispatchQueue.main.async {
                    
//                    Stopping At 150..
                    if videoWidth >= 150{
                    
                        player.width = videoWidth
                    }
                }
                
               return 70
            }
//            Previews will Have Animation Problems..
            DispatchQueue.main.async {
                player.width = UIScreen.main.bounds.width
            }
            return videoHeight
        }
        
        print(progress)
        DispatchQueue.main.async {
            player.width = UIScreen.main.bounds.width
        }
        return 250
    }
    
    func getOpacity()->Double{
        
        let progress = player.offset / (player.height)
        if progress <= 1{
            return Double(1-progress)
        }
        
        return 1
    }
}

struct MiniPlayerYouTubeMiniPlayerTransition_Previews: PreviewProvider {
    static var previews: some View {
      HomeViewYouTubeMiniPlayerTransition()
    }
}

struct PlayBackVideoButtons: View {
    
    var image: String
    var text: String
    
    var body: some View {
        Button {
            
        } label: {
            VStack(spacing: 8){
                Image(systemName: image)
                    .font(.title3)
                
                Text(text)
                    .fontWeight(.semibold)
                    .font(.caption)
            }
        }
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
    }
}

struct VideoControls:View {
    
    @EnvironmentObject var player: VideoPlayerViewModelYouTubeMiniPlayerTransition
    
    var body: some View{
        HStack(spacing: 15){
            
//            video View...
            Rectangle()
                .fill(Color.clear)
                .frame(width: 150, height: 70)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("prova 1")
                    .font(.callout)
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text("Michele")
                    .fontWeight(.bold)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            
            Button {
                
            } label: {
                Image(systemName: "pause.fill")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            Button {
//                withAnimation {
                    player.showPlayer.toggle()
                    player.offset = 0
                    player.isMiniPlayer.toggle()
//                }
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.black)
            }
        }
        .padding(.trailing)
    }
}
