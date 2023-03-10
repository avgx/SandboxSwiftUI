//
//  BarChartSample.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 21.01.2022.
//

import Charts
import SwiftUI

struct BarChartSample : UIViewRepresentable {
    //Bar chart accepts data as array of BarChartDataEntry objects
    var entries : [BarChartDataEntry]
    // this func is required to conform to UIViewRepresentable protocol
    func makeUIView(context: Context) -> BarChartView {
        //crate new chart
        let chart = BarChartView()
        //it is convenient to form chart data in a separate func
        chart.data = addData()
        return chart
    }
    
    // this func is required to conform to UIViewRepresentable protocol
    func updateUIView(_ uiView: BarChartView, context: Context) {
        //when data changes chartd.data update is required
        uiView.data = addData()
    }
    
    func addData() -> BarChartData{
        let data = BarChartData()
        //BarChartDataSet is an object that contains information about your data, styling and more
        let dataSet = BarChartDataSet(entries: entries)
        // change bars color to green
        dataSet.colors = [NSUIColor.green]
        //change data label
        dataSet.label = "My Data"
        data.dataSets = [dataSet]
        return data
    }
    
    typealias UIViewType = BarChartView
    
}



struct BarChartSample_Previews: PreviewProvider {
    static var previews: some View {
        BarChartSample(entries: [
            //x - position of a bar, y - height of a bar
            BarChartDataEntry(x: 1, y: 1),
            BarChartDataEntry(x: 2, y: 2),
            BarChartDataEntry(x: 3, y: 1),
            BarChartDataEntry(x: 4, y: 4),
            BarChartDataEntry(x: 5, y: 1)

        ])
    }
}
