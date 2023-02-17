//
//  MiniplayerAppleMusicAnimationsMiniPlayer.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 02/12/21.
//

import SwiftUI

struct MiniplayerAppleMusicAnimationsMiniPlayer: View {
    var animation : Namespace.ID
    @Binding var expand: Bool
    
    var height = UIScreen.main.bounds.height / 3
    
//    safearea...
    var safearea = UIApplication.shared.windows.first?.safeAreaInsets
    
//    Volume Slider...
    @State var volume: CGFloat = 0
    
//    gesture Offset...
    @State var offset: CGFloat = 0
    
    var body: some View {
        VStack{
            
            Capsule()
                .fill(Color.gray)
                .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
                .padding(.top,expand ? safearea?.top : 0)
                .padding(.vertical,expand ? 30 : 0)
            
            HStack(spacing: 15){
                
//                centering Image...
                if expand{
                    Spacer(minLength: 0)
                }
                
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: expand ? height : 55, height: expand ? height :  55)
                    .cornerRadius(15)
                
                if !expand {
                    Text("Lady Gaga")
                        .font(.title2)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "Label", in: animation)
                }
              
                
                Spacer(minLength: 0)
                
                if !expand{
                    Button {
                    
                } label: {
                    Image(systemName: "play.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                
                    Button {
                    
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                }

            }
            .padding(.horizontal)
            
            VStack(spacing: 15){
                
                Spacer(minLength: 0)
                
                HStack{
                    
                    if expand{
                    Text("Lady Gaga")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "Label", in: animation)
                    }
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellips.circle")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }

                }
                .padding()
                .padding(.top,20)
                
//                Live String...
                HStack{
                    Capsule()
                        .fill(
                            LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.7),Color.primary.opacity(0.1)]), startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(height: 4)
                    
                    Text("LIVE")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Capsule()
                        .fill(
                            LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.1),Color.primary.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(height: 4)
                }
                .padding()
                
//                Stop Button..
                Button {
                    
                } label: {
                    Image(systemName: "stop.fill")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                }
                .padding()

                
                Spacer(minLength: 0)
                
                HStack(spacing: 15){
                    Image(systemName: "speaker.fill")
                    
                    Slider(value: $volume)
                    
                    Image(systemName: "speaker.wave.2.fill")
                }
                .padding()
                
                HStack(spacing: 22){
                    Button {
                        
                    } label: {
                        Image(systemName: "airplayaudio")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "list.bullet")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.up.message")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }

                }
                .padding(.bottom,safearea?.bottom == 0 ? 15 : safearea?.bottom)
            }
//            this will give strech effect..
            .frame(height: expand ? nil : 0)
            .opacity(expand ? 1 : 0)
        }
//        exopanding to full screen when clicked...
        .frame(maxHeight: expand ? .infinity :  80)
//            moving the miniplayer above the tabbar...
//            assproz tab bar height is 49..
        
//        Dvider Line For Separating Miniplayer And Tab Bar...
        .background(
            VStack(spacing: 0){
                BlurViewAppleMusicAnimationsMiniPlayer()
                
                Divider()
            }
                .onTapGesture {
                    withAnimation(.spring()){
                        expand = true
                    }
                }
        )
        .cornerRadius(expand ? 20 : 0)
        .offset(y: expand ? 0 :  -48)
        .offset(y:offset)
        .gesture(DragGesture().onEnded(onEnded(value: )).onChanged(onChanged(value:)))
        .ignoresSafeArea()
    }
    
    func onChanged(value: DragGesture.Value){
        
//         only allowing when its expanded....
        
        if value.translation.height > 0 && expand{
            offset = value.translation.height
        }
    }
    func onEnded(value: DragGesture.Value){
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)){
            
//            if value is > than height / 3 closing view...
            if value.translation.height > height{
                expand = false
            }
            offset = 0
        }
    }
}


