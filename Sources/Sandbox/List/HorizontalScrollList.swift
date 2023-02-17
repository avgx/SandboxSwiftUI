//
//  HorizontalScrollList.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 01.02.2022.
//

import SwiftUI

struct ScrollViewOfYearRanges : View {
    @State private var yearSelectedIndex = 0
    
    //var employeeViewModel : EmployeeViewModel
    
    var body : some View {
        let yearRanges  = [ (0,5), (6,10), (11,15), (16,20), (21,25) ]
        
        ScrollView (.horizontal, showsIndicators: false ) {
            
            HStack {
                
                ForEach ( (0..<yearRanges.count)){
                    idx in
                    
                    let yr = yearRanges[idx]
                    
                    Text("\(yr.0) - \(yr.1)")
                        .frame(width: 80, height: 40)
                        .foregroundColor(.white)
                        .background( (self.yearSelectedIndex == idx) ? Color.green : Color.gray )
                        .cornerRadius(20)
                        .onTapGesture {
                            //self.employeeViewModel.yearsServed( yr.0, yr.1 )
                            self.yearSelectedIndex = idx
                        }
                    
                }
                
            }
        }
        .frame(alignment: .leading)
        
    }
}
