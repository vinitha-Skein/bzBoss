//
//  testCollectionViewCell.swift
//  bzBoss
//
//  Created by Skeintech on 20/07/21.
//

import UIKit
import Charts

class testCollectionViewCell: UICollectionViewCell, ChartViewDelegate {
    @IBOutlet weak var chartview: LineChartView!
    let arrayxString = ["12/07", "13/07", "14/07", "15/07", "16/07","17/07","18/07"]
   
    var value1 = Int()
    var value2 = Int()
    var value3 = Int()
    var value4 = Int()
    var value5 = Int()
    var value6 = Int()
    var value7 = Int()


    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        print(value4)
        

    }
    func setupChart(_ chart: LineChartView, data: LineChartData, color: UIColor)
    {
       
        chart.delegate = self
        chart.backgroundColor = .white
        
        chart.chartDescription!.enabled = false
        
        chart.dragEnabled = true
        chart.setScaleEnabled(true)
        chart.pinchZoomEnabled = false
        chart.setViewPortOffsets(left: 30, top: 0, right: 20, bottom: 30)
        
        chart.legend.enabled = false
        
        chart.leftAxis.enabled = true
        chart.leftAxis.spaceTop = 0.4
        chart.leftAxis.spaceBottom = 0.4
        chart.leftAxis.axisMinimum = 0
        chart.leftAxis.axisRange = 1.0
        chart.leftAxis.labelCount = 2
        chart.leftAxis.granularity = 1.0
//        chart.leftAxis.valueFormatter = XAxisNameFormater()
        chart.rightAxis.enabled = false
        chart.xAxis.enabled = true
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelHeight = 21.0
        
        chart.xAxis.valueFormatter = XAxisNameFormater()
        chart.xAxis.labelCount = arrayxString.count
        chart.xAxis.granularity = 1.0
        chart.data = data
        //        chart.animate(xAxisDuration: 2.5)
    }
    func dataWithCount() -> LineChartData
    {
        let yVals = ChartDataEntry(x: 0.0, y: Double(value1))
        let yval2 = ChartDataEntry(x:1.0,y: Double(value2))
        let yval3 = ChartDataEntry(x:2.0,y:Double(value3))
        let yval4 = ChartDataEntry(x:3.0,y: Double(value4))
        let yval5 = ChartDataEntry(x:4.0, y: Double(value5))
        let yval6 = ChartDataEntry(x:5.0, y: Double(value6))
        let yval7 = ChartDataEntry(x:6.0, y: Double(value7))
        
        
        let set1 = LineChartDataSet(entries: [yVals,yval2,yval3,yval4,yval5,yval6,yval7], label: "DataSet 1")
        
        set1.lineWidth = 1.75
        set1.circleRadius = 5.0
        set1.circleHoleRadius = 2.5
        set1.setColor(.green)
        set1.setCircleColor(.green)
        set1.highlightColor = .white
        set1.drawValuesEnabled = false
        set1.mode = LineChartDataSet.Mode.horizontalBezier
        
        return LineChartData(dataSet: set1)
    }
    func valuefor1(str : Int){
        value1 = str
    }
    func valuefor2(str : Int){
        value2 = str
    }
    func valuefor3(str : Int){
        value3 = str
    }
    func valuefor4(str : Int){
        value4 = str
    }
    func valuefor5(str : Int){
        value5 = str
    }
    func valuefor6(str : Int){
        value6 = str
    }
    func valuefor7(str : Int)
    {
        value7 = str
        chartview.backgroundColor = UIColor.white
        let data1 = dataWithCount()
        data1.setValueFont(UIFont(name: "HelveticaNeue", size: 7)!)
        setupChart(chartview, data: data1, color: .green)
        
    }
}
