//
//  TabBarAppStoreAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 01/12/21.
//

import SwiftUI

struct TabBarAppStoreAnimations: View {
    @Namespace var animation
    @StateObject var detailObject = DetailViewModelAppStoreAnimations()
    var body: some View {
        ZStack {
            TabView{
               TodayAppStoreAnimations(animation: animation)
                    .environmentObject(detailObject)
                    .tabItem {
    //                    Image("house")
    //                        .resizable
    //////                        .renderingMode(.template)
    //                        .frame(width: 2, height: 2)
            
                        Text("Today")
                    }
                Text("Games")
                    .tabItem {
    //                    Image("p2")
    //                        .resizable()
    ////                        .renderingMode(.template)
    //                        .frame(width: 4, height: 4)
                        Text("Games")
                    }
                Text("Apps")
                    .tabItem {
    //                    Image("p3")
    //                        .resizable()
    ////                        .renderingMode(.template)
    //                        .frame(width: 4, height: 4)
                        Text("Apps")
                    }
                Text("Search")
                    .tabItem {
    //                    Image("search")
    //                        .resizable()
    ////                        .renderingMode(.template)
    //                        .frame(width: 4, height: 4)
                        Text("Search")
                    }
            }
            
//            hiding tab bar when detail page opnes...
            .opacity(detailObject.show ? 0 : 1)
            
            if detailObject.show{
                DetailAppStoreAnimations(detail: detailObject, animations: animation)
            }
        }
    }
}

struct TabBarAppStoreAnimations_Previews: PreviewProvider {
    static var previews: some View {
        TabBarAppStoreAnimations()
    }
}
