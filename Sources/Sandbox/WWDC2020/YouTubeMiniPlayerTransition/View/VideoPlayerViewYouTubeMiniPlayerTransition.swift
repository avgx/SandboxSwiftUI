//
//  VideoPlayerViewYouTubeMiniPlayerTransition.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI
import AVKit

struct VideoPlayerViewYouTubeMiniPlayerTransition: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        
        let controller = AVPlayerViewController()
//        video URL..
        let bundle_url = Bundle.main.path(forResource: "video", ofType: "mp4")
        let video_url = URL(fileURLWithPath: bundle_url!)
        
//        Player...
        let player = AVPlayer(url: video_url)
        
        controller.player = player
        
//        Hiding Controls..
        controller.showsPlaybackControls = false
//        controller.player?.play()
        controller.videoGravity = .resizeAspectFill
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
}

