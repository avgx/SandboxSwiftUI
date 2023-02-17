//
//  DetailAppStoreAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 02/12/21.
//

import SwiftUI

struct DetailAppStoreAnimations: View {
    //    Getting Current Selected Item...
    @ObservedObject var detail : DetailViewModelAppStoreAnimations
    var animations: Namespace.ID
    
    @State var scale: CGFloat = 1
    
    var body: some View {
        
        ScrollView{
            VStack{
                
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    
                    Image(detail.selectedItem.contentImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: detail.selectedItem.contentImage, in: animations)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)
                    
                    HStack{
                        Text(detail.selectedItem.overlay)
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)){
                                detail.show.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color.black.opacity(0.7))
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)
//                    since we ignored top area...
                    .padding(.top,UIApplication.shared.windows.first!.safeAreaInsets.top + 10)
                }
//                Gesture For Closing Detail View..
                .gesture(DragGesture(minimumDistance: 0).onChanged(onChanged(value: )).onEnded(onEnded(value: )))
                
                HStack{
                    Image(detail.selectedItem.logo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height: 65)
                        .cornerRadius(15)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(detail.selectedItem.title)
                            .fontWeight(.bold)
                        
                        Text(detail.selectedItem.category)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer(minLength: 0)
                    VStack{
                        Button {
                            
                        } label: {
                            Text("GET")
                                .fontWeight(.bold)
                                .padding(.vertical,10)
                                .padding(.horizontal,25)
                                .background(Color.primary.opacity(0.1))
                                .clipShape(Capsule())
                        }
                        
                        Text("In App Purchases")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                    }
                }
                .matchedGeometryEffect(id: detail.selectedItem.id, in: animations)
                .padding()
                Text("qwertyyuiopasdfghjjklzxcvbnmx")
                    .padding()
                
                Button {
                    
                } label: {
                    Label {
                        Text("Share")
                            .foregroundColor(.primary)
                    } icon: {
                        Image(systemName: "square.and.arrow.up.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal,25)
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
            }
        }
        .scaleEffect(scale)
        .ignoresSafeArea(.all, edges: .top)
    }
    
    func onChanged(value: DragGesture.Value){
        
//        calculating sclae value by total height...
        let scale = value.translation.height / UIScreen.main.bounds.height
        
//        if scale is 0.1 means the actual scale will be 1- 0.1 => 0.9
//        limiting scale value...
        if 1 - scale > 0.7{
            self.scale = 1 - scale
        }
        
    }
    
    func onEnded(value: DragGesture.Value){
        withAnimation(.spring()){
            
//            closing detail view when scale is less than 0.9.....
            if scale < 0.9{
                detail.show.toggle()
            }
            scale = 1
        }
    }
}

