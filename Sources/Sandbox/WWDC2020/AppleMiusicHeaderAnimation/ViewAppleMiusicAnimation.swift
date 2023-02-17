//
//  ViewAppleMiusicAnimation.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/10/21.
//

import SwiftUI

struct ViewAppleMiusicAnimation: View {
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var opacity : Double = 0
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
//                    First Parallax Scroll...
                    GeometryReader{ reader in
                        VStack{
                            Image("p1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
//                            default width...
                                .frame(width: UIScreen.main.bounds.width,
                                       height: reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + (UIScreen.main.bounds.height / 2.2) : UIScreen.main.bounds.height / 2.2)
//                            adjusting view position when scrolls..
                                .offset(y: -reader.frame(in: .global).minY)
//                            NavBar Cahnge...
                                .onChange(of: reader.frame(in: .global).minY) { value in
//                                    cheking if top is reached...
                                    let offset = value + (UIScreen.main.bounds.height / 2.2)
                                    if offset < 80{
//                                        rating from 0 - 80
                                        if offset > 0{
//                                            calculating opacity...
                                            let opacity_value = (80 - offset) / 80
                                            self.opacity = Double(opacity_value)
                                            return
                                        }
//                                        else menas
                                        self.opacity = 1
                                    }
                                    else{
                                        self.opacity = 0
                                    }
                                }
                        }
                    }
//                    Setting default height...
                    .frame(height: UIScreen.main.bounds.height / 2.2)
//                    List Of Songs...
                    VStack(spacing: 10){
                        ForEach(albums,id: \.album_name){ album in
                            
                            HStack(spacing: 15){
                                Image("\(album.album_cover)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 55, height: 55)
                                    .cornerRadius(15)
                                VStack(alignment: .leading, spacing: 5) {
                                    
                                    Text("\(album.album_name)")
                                    
                                    Text("\(album.album_author)")
                                        .font(.caption)
                                }
                                Spacer(minLength: 0)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                    .background(Color.white)
                }
            }
            
            HStack{
                Button {
                    
                } label: {
                    HStack(spacing: 8){
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22, weight: .bold))
                        
                        Text("Search")
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image("p2")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 22, height: 22)
                            .rotationEffect(.init(degrees: 90))
                    }

                }

            }
            .padding()
            .foregroundColor(opacity > 0.6 ? .black : .white)
//          since top eges is ignored...
            .padding(.top,edges!.top)
            .background(Color.white.opacity(opacity))
            .shadow(color: Color.black.opacity(opacity > 0.8 ? 0.1 : 0), radius: 5, x: 0, y: 5)
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct ViewAppleMiusicAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ViewAppleMiusicAnimation()
    }
}

//sample data...
struct Album{
    var album_name : String
    var album_author : String
    var album_cover : String
}
var albums = [
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p1"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p2"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p3"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p4"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p5"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p1"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p2"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p3"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p4"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p5")
]
