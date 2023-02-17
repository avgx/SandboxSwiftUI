//
//  BlurViewAppleMusicAnimationsMiniPlayer.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 02/12/21.
//

import SwiftUI

struct BlurViewAppleMusicAnimationsMiniPlayer: UIViewRepresentable {
  
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

