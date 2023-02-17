//
//  HomeTabViewWithSwipeGesture.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 15/09/21.
//

import SwiftUI

struct HomeTabViewWithSwipeGesture: View {
    
    @State var index = 0
   
    
    var body: some View {
        VStack{
            HStack{
                Text("STAT")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color"))
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
            
//            Tab View...
            
            HStack(spacing: 0){
               
                Text("Day")
                    .foregroundColor(self.index == 0 ? .white : Color("Color").opacity(0.7))
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color("Color").opacity(self.index == 0 ? 1 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(.default){
                            self.index = 0
                        }
                    }
                
                Spacer(minLength: 0)
                
                Text("Week")
                    .foregroundColor(self.index == 1 ? .white : Color("Color").opacity(0.7))
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color("Color").opacity(self.index == 1 ? 1 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(.default){
                            self.index = 1
                        }
                    }
                Spacer(minLength: 0)
                
                Text("Month")
                    .foregroundColor(self.index == 2 ? .white : Color("Color").opacity(0.7))
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color("Color").opacity(self.index == 2 ? 1 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(.default){
                            self.index = 2
                        }
                    }
            }
            .background(Color.black.opacity(0.06))
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.top,25)
            
//            dashBoard Grid...
//            Tab View With Swipe Gesture....
            
//          connecting index with tabview for tab change..
            TabView(selection: self.$index){
                
                GrigliaView(fitness_Data: fit_Data)
                    .tag(0)
                GrigliaView(fitness_Data: week_Fit_Data)
                    .tag(1)
                VStack{
                    Text("Monthly Data")
                }
                .tag(2)
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer(minLength: 0)
        }
        .padding(.top)
    }
}

struct HomeTabViewWithSwipeGesture_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabViewWithSwipeGesture()
    }
}

//DashBoard Grid Model Data...
struct Fitness: Identifiable {
    var id : Int
    var title : String
    var image : String
    var data : String
    var suggest : String
}

//Grid View...
struct GrigliaView: View {
    
    var fitness_Data : [Fitness]
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View{
        
        LazyVGrid(columns: columns,spacing: 30, content: {
            ForEach(fitness_Data){ fitnes in
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                    VStack(alignment: .leading, spacing: 20, content: {
                        Text(fitnes.title)
                            .foregroundColor(.white )
                        
                        Text(fitnes.data)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top,10)
                        
                        HStack{
                            
                            Spacer(minLength: 0)
                            
                            Text(fitnes.suggest)
                                .foregroundColor(.white)
                        }
                    })
                    .padding()
                    .background(Color(fitnes.image))
                    .cornerRadius(20)
//                        shadow..
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    
//                        Top image..
                    Image(fitnes.image)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)

                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.12))
                        .clipShape(Circle())
                }
            )}
        })
        .padding(.horizontal)
        .padding(.top,25)
    }
}


//Daily Data...

var fit_Data = [
    Fitness(id: 0, title: "heartRate", image: "heart", data: "124 bpm", suggest: "80-120\nHealthy"),
    Fitness(id: 1, title: "cycleRate", image: "cycle", data: "194 bpm", suggest: "80-120\nHealthy"),
    Fitness(id: 2, title: "energy", image: "energy", data: "1000 kcal", suggest: "80-120\nHealthy"),
    Fitness(id: 3, title: "runningRate", image: "running", data: "194 bpm", suggest: "80-120\nHealthy"),
    Fitness(id: 4, title: "sleep", image: "sleep", data: "80 bpm", suggest: "80-90\nHealthy"),
    Fitness(id: 5, title: "stepsRate", image: "steps", data: "184 bpm", suggest: "80-120\nHealthy")
]

// Monthly Data...
var week_Fit_Data = [
    Fitness(id: 0, title: "heartRate", image: "heart", data: "124 bpm", suggest: "80-120\nHealthy"),
    Fitness(id: 1, title: "cycleRate", image: "cycle", data: "194 bpm", suggest: "80-120\nHealthy"),
    Fitness(id: 2, title: "energy", image: "energy", data: "1000 k/cal", suggest: "80-120\nHealthy"),
    Fitness(id: 3, title: "runningRate", image: "running", data: "194 bpm", suggest: "80-120\nHealthy"),
    Fitness(id: 4, title: "sleep", image: "sleep", data: "80 bpm", suggest: "80-90\nHealthy"),
    Fitness(id: 5, title: "stepsRate", image: "steps", data: "184 bpm", suggest: "80-120\nHealthy")
]
