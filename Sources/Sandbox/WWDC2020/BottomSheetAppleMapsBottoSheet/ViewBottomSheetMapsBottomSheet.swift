//
//  ViewBottomSheetMapsBottomSheet.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/10/21.
//

import SwiftUI
import MapKit

struct ViewBottomSheetMapsBottomSheet: View {
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.629895, longitude: 9.029334), latitudinalMeters: 10000,longitudinalMeters: 10000)
    @State var offset : CGFloat = 0
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            Map(coordinateRegion: $region)
                .ignoresSafeArea(.all, edges: .all)
            
//            to read frame height...
            GeometryReader{ reader in
                VStack {
                    BottomSheet2020(offset: $offset, value: (-reader.frame(in: .global).height + 150))
                        .offset(y: reader.frame(in: .global).height - 140)
//                  adding gesture...
                        .offset(y: offset)
                        .gesture(DragGesture().onChanged({ value in
                            withAnimation {
                                
//                                checking the direction of scroll...
//                                scroll upWards...
//                            using startLocation bcz translation will change when we drag up and down...
                                if value.startLocation.y > reader.frame(in: .global).midX{
                                    
                                    if value.translation.height < 0 && offset > (-reader.frame(in: .global).height + 150){
                                        offset = value.translation.height
                                    }
                                }
                                if value.startLocation.y < reader.frame(in: .global).midX{
                                    
                                    if value.translation.height > 0 && offset < 0{
                                        offset = (-reader.frame(in: .global).height + 150) + value.translation.height
                                    }
                                    
                                   
                                }
                            }
                        }).onEnded({ value in
                            withAnimation {
//                               checking and pulling up the screen...
                                if value.startLocation.y > reader.frame(in: .global).midX{
                                    
                                    if -value.translation.height > reader.frame(in: .global).midX{
                                        offset = (-reader.frame(in: .global).height + 150)
                                        return
                                    }
                                    
                                    offset = 0
                                }
                                if value.startLocation.y < reader.frame(in: .global).midX{
                                    
                                    if value.translation.height < reader.frame(in: .global).midX{
                                        offset = (-reader.frame(in: .global).height + 150)
                                        return
                                    }
                                    
                                    offset = 0
                                }
                            }
                        }))
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
        })
    }
}

struct ViewBottomSheetMapsBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        ViewBottomSheetMapsBottomSheet()
    }
}

struct BottomSheet2020: View {
    
    @State var txt = ""
    @Binding var offset : CGFloat
    var value : CGFloat
    
    var body: some View{
        VStack{
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom,5)
            
            HStack(spacing: 15){
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 22))
                    .foregroundColor(.gray)
                
                TextField("Search Place", text: $txt) { status in
                    withAnimation {
                        offset = value
                    }
                } onCommit: {
                    
                }

                
            }
            .padding(.vertical,10)
            .padding(.horizontal)
//            Blur view....
//            For Dark Mode Adoption...
            .background(BlurViewMaps(style: .systemMaterial))
            .cornerRadius(15)
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVStack(alignment: .leading, spacing: 15) {
                    
                    ForEach(1...15,id:\.self) { count in
                        
                        Text("Search Place")
                        
                        Divider()
                            .padding(.top,10)
                    }
                }
                .padding()
                .padding(.top)
            }
        }
        .background(BlurViewMaps(style: .systemMaterial))
        .cornerRadius(15)
    }
}
struct BlurViewMaps : UIViewRepresentable {
    
    var style : UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView{
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
