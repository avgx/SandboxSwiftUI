//
//  VideoPlayerViewModelYouTubeMiniPlayerTransition.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI

class VideoPlayerViewModelYouTubeMiniPlayerTransition: ObservableObject {

//    MiniPlayer Properties..
    @Published var showPlayer = false
    
//    Gesture Offset...
    @Published var offset: CGFloat = 0
    @Published var width : CGFloat = UIScreen.main.bounds.width
    @Published var height: CGFloat = 0
    @Published var isMiniPlayer = false
}

