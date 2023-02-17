//
//  ImageViewMultipleImageViewer.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 19/12/21.
//

import SwiftUI

struct ImageViewMultipleImageViewer: View {
    
    @EnvironmentObject var homeData: HomeViewModelMultipleImageViewer
//    since onChange has a problem in Drag Gesture...
    @GestureState var draggingOffset: CGSize = .zero
    
    var body: some View {
        
        ZStack{
           
            
            
//            Tab View Hap a problem in ignoring edges..
            ScrollView(.init()){
                TabView(selection: $homeData.selectedImageID) {
                    
                    ForEach(homeData.allImages,id:\.self){image in
                        
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tag(image)
                            .scaleEffect(homeData.selectedImageID == image ? (homeData.imageScale > 1 ? homeData.imageScale : 1) : 1)
    //                    Moving Only Image...
    //                    For Smooth Animation...
                            .offset(y:homeData.imageViewerOffset.height)
                            .gesture(
                                MagnificationGesture().onChanged({ value  in
                                    homeData.imageScale = value
                                }).onEnded({ _ in
                                    withAnimation(.spring()){
                                        homeData.imageScale = 1
                                    }
                                })
//                                Double To Zoom...
                                    .simultaneously(with: TapGesture(count: 2).onEnded({ _ in
                                        withAnimation {
                                            homeData.imageScale = homeData.imageScale > 1 ? 1 : 4
                                        }
                                    }))
                            )
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .overlay(
    //                Close Button...
                    Button(action: {
                        withAnimation(.default){
    //                        Removing All...
                            homeData.showImageViewer.toggle()
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.35))
                            .clipShape(Circle())
                    })
                    .padding(10)
                    .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .opacity(homeData.bgOpacity)
                    
                    ,alignment: .topTrailing
                )
            }
            .ignoresSafeArea()
            
        }
        .gesture(DragGesture().updating($draggingOffset, body: { value, outValue, _ in
            outValue = value.translation
            homeData.onChange(value: draggingOffset)
            
        }).onEnded(homeData.onEnd(value:)))
        .transition(.move(edge: .bottom))

    }
}

struct ImageViewMultipleImageViewer_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewMultipleImageViewer()
    }
}
