//
//  TabBarAppleMusicAnimationsMiniPlayer.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 02/12/21.
//

import SwiftUI

struct TabBarAppleMusicAnimationsMiniPlayer: View {
//    Selected Tab Index...
//    Default is third...
    @State var current = 2
//    Miniplayer Properties...
    @State var expand = false
    
    @Namespace var animation 
    
    var body: some View {
        
//        Bottom Minu Player....
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $current) {
                Text("Library")
                    .tag(0)
                    .tabItem {
                        
                        Image(systemName: "rectangle.stack.fill")
                        
                        Text("Library")
                    }
                
                Text("Radio")
                    .tag(1)
                    .tabItem {
                        
                        Image(systemName: "dot.radiowaves.left.and.right")
                        
                        Text("Radio")
                    }
                SearchAppleMusicAnimationsMiniPlayer()
                    .tag(2)
                    .tabItem {
                        
                        Image(systemName: "magnifyingglass")
                        
                        Text("Search")
                    }
            }
            
            MiniplayerAppleMusicAnimationsMiniPlayer(animation: animation, expand: $expand)
        }
        
    }
}

