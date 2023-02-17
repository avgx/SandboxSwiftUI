//
//  TodayItemAppStoreAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 02/12/21.
//

import SwiftUI

struct TodayItemAppStoreAnimations: Identifiable{
    
    var id = UUID().uuidString
    var title: String
    var category: String
    var overlay: String
    var contentImage: String
    var logo: String
}

var itemsAppStoreAnimation = [
    TodayItemAppStoreAnimations(title: "Forza Feet", category: "prova1", overlay: "GAME DAY", contentImage: "g1", logo: "p1"),
    TodayItemAppStoreAnimations(title: "Rolbox", category: "Adventure", overlay: "Li Nas X Performs In Roblox", contentImage: "g2", logo: "p2")
]
