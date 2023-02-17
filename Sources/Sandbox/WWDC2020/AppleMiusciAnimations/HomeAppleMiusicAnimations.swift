//
//  HomeAppleMiusicAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 13/09/21.
//

import SwiftUI

struct HomeAppleMiusicAnimations: View {
    
    @State var show = false
    @State var progress : CGFloat = 0
    @Namespace var namespace
    
    var body: some View {
        VStack{
            Spacer()
//            Minimised View...
            VStack(spacing: 35) {
                HStack(spacing: 15, content: {
                    
//                  Resizing image...
                    
                    Image("album")
                        .resizable()
                        .frame(width: self.show ? 250 : 50, height: self.show ? 250 :  50)
                        .padding(.top,self.show ? 35 : 0)
                    
//                    hiding view if its expanded...
                    
                    if !self.show{
                        VStack(alignment: .leading, spacing: 4, content: {
                            Text("Cristo delle vette 4200 msl")
                            Text("Michele Manniello")
                                .foregroundColor(.red)
                        })
                        .matchedGeometryEffect(id: "Details", in: self.namespace)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "play.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        })
                        .matchedGeometryEffect(id: "play", in: self.namespace)

                    }
                })
//                moving view up...
                
//                problema in View...
                
                if self.show{
                    VStack(alignment: .center, spacing: 4, content: {
                        Text("Cristo delle vette 4200 msl")
                        Text("Michele Manniello")
                            .foregroundColor(.red)
                    })
                    .matchedGeometryEffect(id: "Details", in: self.namespace)

                        
                    Slider(value: self.$progress)
                    
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "backward.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "play.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        })
//                        Only for play button
                        .matchedGeometryEffect(id: "play", in: self.namespace)

                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "forward.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        })
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    HStack{
                        Button(action: {}, label: {
                            Image(systemName: "square.and.arrow.down.fill")
                                .foregroundColor(.black)
                                .font(.title)
                        })
                        
                        Spacer()
                    }
                    .padding([.horizontal,.bottom])
                }
            }
            .padding(.all)
            .background(Color.white.shadow(radius: 3).onTapGesture {
                //            View Expand...
                withAnimation {
                    //                view Expand...
                    withAnimation(Animation.easeIn(duration: 0.4 )) {
                        self.show.toggle()
                    }
                }
            })
        }
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.all))
    }
}

struct HomeAppleMiusicAnimations_Previews: PreviewProvider {
    static var previews: some View {
        HomeAppleMiusicAnimations()
    }
}
