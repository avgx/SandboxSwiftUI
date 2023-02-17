//
//  GridImageViewMultipleImageViewer.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 19/12/21.
//

import SwiftUI

struct GridImageViewMultipleImageViewer: View {
    
    @EnvironmentObject var homeData: HomeViewModelMultipleImageViewer
    var index: Int
    
    var body: some View {
    
        Button {
            withAnimation(.easeInOut){
//                For Page Tab View Automatic Scrolling...
                homeData.selectedImageID = homeData.allImages[index]
                homeData.showImageViewer.toggle()
            }
        } label: {
            ZStack{
                
    //            Showing only Four Grids...
                
                if index <= 3{
                    
                    Image(homeData.allImages[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getWidth(index: index), height: 120)
                        .cornerRadius(12)
                }
                
    //            showing the count of remaining images...
                
                if homeData.allImages.count > 4 && index == 3{
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.3))
                    
                    let remainingImages = homeData.allImages.count - 4
                    
                    Text("+\(remainingImages)")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
            }
        }

    }
    
//    expanding Image Size when space is availble...
    
    func getWidth(index: Int) -> CGFloat {
        
        let width = getRectMultipleImageViewer().width - 100
        
        if homeData.allImages.count % 2 == 0{
            return width / 2
        }else{
            if index == homeData.allImages.count - 1{
                return width
            }else{
                return width / 2
            }
        }
    }
    
    
}

struct GridImageViewMultipleImageViewer_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewMultipleImageViewer()
    }
}

// extending View to get screen Size...

extension View{
    
    func getRectMultipleImageViewer() -> CGRect{
        return UIScreen.main.bounds
    }
}
