//
//  HomeCustomGridsAndAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 13/09/21.
//

import SwiftUI

struct HomeCustomGridsAndAnimations: View {
    @State var search = ""
    @State var index = 0
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack{
                HStack{
                    Text("Game Store")
                        .font(.title)
                        .fontWeight(.bold)
                        Spacer()
                }
                .padding(.horizontal)
                
                TextField("Search", text: self.$search)
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.07))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top,25)
                
//                Carousel List...
                TabView(selection: self.$index){
                    ForEach(0...5,id: \.self){ index in
                        Image("p\(index)")
                            .resizable()
//                            adding animation....
                            .frame(height: self.index == index ?  230 : 180)
                            .cornerRadius(15)
                            .padding(.horizontal)
//                           for identifyubg current index....
                            .tag(index)
                    }
                }
                .frame(height: 230)
                .padding(.top,25)
                .tabViewStyle(PageTabViewStyle())
                .animation(.easeInOut)
                
//                adding custom Grid...
                HStack{
                    Text("Popular")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        
//                        Redcing to row..
                        withAnimation(.easeOut){
                            if self.columns.count == 2{
                                self.columns.removeLast()
                            }else{
                                self.columns.append(GridItem(.flexible(), spacing: 15))
                            }
                        }
                        
                    }, label: {
                        Image(systemName: self.columns.count == 2 ? "rectangle.grid.1x2" : "square.grid.2x2")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    })
                }
                .padding(.horizontal)
                .padding(.top,25)
                
                LazyVGrid(columns: columns,spacing: 25, content: {
                    
                    ForEach(data){ game in
//                        Grid View...
                        GridView(game: game, columns: self.$columns)
                    }
                })
                .padding([.horizontal,.top])
                
            }
            .padding(.vertical)
        })
        .background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.all))
    }
}

struct HomeCustomGridsAndAnimations_Previews: PreviewProvider {
    static var previews: some View {
        HomeCustomGridsAndAnimations()
    }
}

struct GridView: View {
    
    var game : Game
    @Binding var columns : [GridItem]
    @Namespace var namespace
    
    var body: some View{
        
        VStack {
            if self.columns.count == 2 {
                VStack(spacing: 15){
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                        Image(game.image)
                            .resizable()
                            .frame(height: 250)
                            .cornerRadius(15)
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .padding(.all,10)
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                        .padding(.all,10)
                    })
                    .matchedGeometryEffect(id: "image", in: self.namespace)
                    
                    Text(game.name)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .matchedGeometryEffect(id: "title", in: self.namespace)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Buy Now")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal,25)
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                    .matchedGeometryEffect(id: "buy", in: self.namespace)
                }
            }
            else{
//                Row View...
//                adding animation...
                
                HStack(spacing: 15){
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                        Image(game.image)
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 250)
                            .cornerRadius(15)
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .padding(.all,10)
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                        .padding(.all,10)
                    })
                    .matchedGeometryEffect(id: "image", in: self.namespace)
                    VStack(alignment: .leading, spacing: 10, content: {
                          
                        Text(game.name)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: "title", in: self.namespace)
//                        Rating Bar...
                        HStack(spacing: 10){
                            ForEach(1...5,id:\.self){ rating in
                                Image(systemName: "star.fill")
                                    .foregroundColor(self.game.rating >= rating ? .yellow : .gray)
                            }
                            Spacer(minLength: 0)
                        }
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Buy Now")
                                .foregroundColor(.white)
                                .padding(.vertical,10)
                                .padding(.horizontal,25)
                                .background(Color.red)
                                .cornerRadius(10)
                        })
                        .padding(.top,10)
                        .matchedGeometryEffect(id: "buy", in: self.namespace)
                    })
                }
                .padding(.trailing)
                .background(Color.white)
                .cornerRadius(15)
            }
        }
    }
}

struct Game: Identifiable {
    var id: Int
    var name : String
    var image : String
    var rating : Int
}

fileprivate var data = [
    Game(id: 0, name: "montagna1", image: "p1", rating: 3),
    Game(id: 1, name: "montagna2", image: "p2", rating: 5),
    Game(id: 2, name: "montagna3", image: "p3", rating: 7),
    Game(id: 3, name: "montagna4", image: "p4", rating: 2),
    Game(id: 4, name: "montagna5", image: "p5", rating: 3),
    
]
