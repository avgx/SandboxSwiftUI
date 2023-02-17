//
//  HomeViewModelMultipleImageViewer.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 19/12/21.
//

import SwiftUI

class HomeViewModelMultipleImageViewer: ObservableObject {
   
    @Published var allImages: [String] = ["p1,","p2","p3","p4","p5","p6"]
    
//    Properties For Image Viewer...
    @Published var showImageViewer  = false
    
    @Published var selectedImageID: String = ""
    
    @Published var imageViewerOffset: CGSize = .zero
    
//    BG Opacity...
    @Published var bgOpacity: Double = 1
    
//    Scaling...
    @Published var imageScale: CGFloat = 1
    
    func onChange(value: CGSize){
//        updating Offset...
        imageViewerOffset = value
        
//        calculating opacity...
        let halgHeight = UIScreen.main.bounds.height / 2
        
        let progress = imageViewerOffset.height / halgHeight
        
        withAnimation(.default){
            bgOpacity = Double(1 - (progress < 0 ? -progress : progress))
        }
        
    }
    
    func onEnd(value: DragGesture.Value){
        
        withAnimation(.easeInOut){
            var translation = value.translation.height
            
            if translation < 0{
                translation = -translation
            }
            
            if translation < 250{
                imageViewerOffset = .zero
                bgOpacity = 1
            }else{
                
                showImageViewer.toggle()
                imageViewerOffset = .zero
                bgOpacity = 1
            }
        }
    }
    
}

