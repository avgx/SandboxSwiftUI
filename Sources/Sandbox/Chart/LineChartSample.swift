//
//  LineChartSample.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 21.01.2022.
//

import Charts
import SwiftUI

struct LineChartSample : UIViewRepresentable {
    @State var lineChart = LineChartView()
    
    var entries : [ChartDataEntry]
    
    func setUpChart() {
        lineChart.noDataText = "no_data_availabe"
        let sensorName = "unknown"
        
        let colors = [UIColor.purple, UIColor.blue, UIColor.red, UIColor.green, UIColor.orange]
        var iterator = colors.makeIterator()
        
        let lineDataEntries = self.entries//lineChartDataEntries(from: [])
        let lineChartDataSet = LineChartDataSet(entries: lineDataEntries, label: sensorName)
        lineChartDataSet.setColor(iterator.next()!)
        lineChartDataSet.mode = .linear
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.drawValuesEnabled = false
        lineChartDataSet.lineWidth = 2
        lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = false
        lineChartDataSet.drawVerticalHighlightIndicatorEnabled = false
        
        guard lineDataEntries.count > 0 else { return }
        
        lineChart.data = LineChartData(dataSet: lineChartDataSet)
//
//        lineChart.leftAxis.axisMinimum = min(minY, Double(viewModel.selectedMeasure.showMin))
//        lineChart.leftAxis.axisMaximum = max(maxY, Double(viewModel.selectedMeasure.showMax))
        setupLineChart()
//        let limitLines = getLimitLines(for: self.viewModel.selectedMeasure)
//        for limitLine in limitLines {
//            lineChart.leftAxis.addLimitLine(limitLine)
//        }
//        lineChart.leftAxis.drawLimitLinesBehindDataEnabled = true
    }
    
    private func setupLineChart() {
        lineChart.legend.enabled = false
        lineChart.rightAxis.enabled = false
        
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.labelTextColor = .black
        lineChart.xAxis.granularityEnabled = true
        lineChart.xAxis.drawLabelsEnabled = true
        lineChart.xAxis.drawAxisLineEnabled = true //false
//        lineChart.xAxis.valueFormatter = ChartsDateValueFormatter()
        lineChart.xAxis.granularity = 1.0
        lineChart.xAxis.drawGridLinesEnabled = true
        lineChart.xAxis.axisMinimum = 0
        //lineChart.xAxis.axisMaximum = 7
        
        lineChart.leftAxis.granularity = 1.0
        lineChart.leftAxis.drawGridLinesEnabled = true
        lineChart.leftAxis.drawAxisLineEnabled = true
        
        lineChart.leftAxis.labelTextColor = .black
        
        //lineChart.leftAxis.drawGridLinesEnabled = false
        //lineChart.leftAxis.removeAllLimitLines()
        
        lineChart.doubleTapToZoomEnabled = false
        lineChart.pinchZoomEnabled = false
        lineChart.scaleXEnabled = false
        lineChart.scaleYEnabled = false
    }
    
//    private func lineChartDataEntries(from sensorReadings: [SensorData]) -> [ChartDataEntry] {
//        sensorReadings.map {
//            let date = DateFormatter.iso8601Full.date(from: $0.stamp) ?? Date()
//            let x =  date.timeIntervalSince1970
//            let y = Double($0.value)!
//            return ChartDataEntry(x: x, y: y)
//        }
//    }
    
    //var entries : [LineChartDataEntry]
    
    func makeUIView(context: Context) -> LineChartView {
//        //crate new chart
//        let chart = LineChartView()
//        //it is convenient to form chart data in a separate func
//        chart.noDataText = "No data"
//        //chart.data = addData()
//        return chart
        
        setUpChart()
        return lineChart
    }
    
    // this func is required to conform to UIViewRepresentable protocol
    func updateUIView(_ uiView: LineChartView, context: Context) {
        //when data changes chartd.data update is required
        //uiView.data = addData()
    }
    typealias UIViewType = LineChartView
    
//    func addData() -> BarChartData{
//        let data = BarChartData()
//        //BarChartDataSet is an object that contains information about your data, styling and more
//        let dataSet = BarChartDataSet(entries: entries)
//        // change bars color to green
//        dataSet.colors = [NSUIColor.green]
//        //change data label
//        dataSet.label = "My Data"
//        data.dataSets = [dataSet]
//        return data
//    }
}

//class ChartsDateValueFormatter: DateFormatter, AxisValueFormatter {
//    override init() {
//        super.init()
//        self.dateFormat = " h a "
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return self.string(from: Date(timeIntervalSince1970: value))
//    }
//}


struct LineChartSample_Previews: PreviewProvider {
    static var previews: some View {
        LineChartSample(entries: [
            //x - position of a bar, y - height of a bar
            ChartDataEntry(x: 1, y: 1),
            ChartDataEntry(x: 2, y: 2),
            ChartDataEntry(x: 3, y: 1),
            ChartDataEntry(x: 4, y: 4),
            ChartDataEntry(x: 5, y: 1)
        ])
    }
}
