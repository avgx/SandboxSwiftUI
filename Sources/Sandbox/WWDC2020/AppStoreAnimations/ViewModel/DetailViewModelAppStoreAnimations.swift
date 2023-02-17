//
//  DetailViewModelAppStoreAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 02/12/21.
//

import SwiftUI

class DetailViewModelAppStoreAnimations: ObservableObject {
    @Published var selectedItem = TodayItemAppStoreAnimations(title: "", category: "", overlay: "", contentImage: "", logo: "")
    
    @Published var show = false
}

