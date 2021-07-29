//
//  testCollectionViewCell.swift
//  bzBoss
//
//  Created by Skeintech on 20/07/21.
//

import UIKit
import Charts

class testCollectionViewCell: UICollectionViewCell, ChartViewDelegate {
    @IBOutlet weak var staffLabel: UILabel!
    @IBOutlet weak var chartview: LineChartView!
    @IBOutlet weak var staffImage: UIImageView!
    var arrayxString = ["12/07", "13/07", "14/07", "15/07", "16/07","17/07","18/07"]
    var arrayYaxisString = [Double]()

    override func awakeFromNib()
    {
        super.awakeFromNib()
        

    }
    func setupChart(_ chart: LineChartView, data: LineChartData, color: UIColor)
    {
       
        chart.delegate = self
        chart.backgroundColor = .white
        
        chart.chartDescription!.enabled = false
        
        chart.dragEnabled = true
        chart.setScaleEnabled(true)
        chart.pinchZoomEnabled = false
        chart.setViewPortOffsets(left: 60, top: 0, right: 20, bottom: 30)
        chart.legend.enabled = false
        chart.leftAxis.enabled = true
        chart.leftAxis.spaceTop = 0.4
        chart.leftAxis.spaceBottom = 0.4
        chart.leftAxis.labelCount = 4
        chart.leftAxis.valueFormatter = YAxisNameFormater()
        chart.rightAxis.enabled = false
        chart.xAxis.enabled = true
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelHeight = 21.0
        
        chart.xAxis.valueFormatter = XAxisNameFormater()
        chart.xAxis.labelCount = arrayxString.count
        chart.xAxis.granularity = 1.0
        chart.data = data
    }
    func dataWithCount() -> LineChartData
    {
        var yVals = [ChartDataEntry]()
        
        for i in 0..<arrayYaxisString.count {
            print(arrayYaxisString[i])
            let date1 = Date(timeIntervalSince1970: TimeInterval(arrayYaxisString[i]))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let localDate = dateFormatter.string(from: date1)
            print(localDate)
            yVals.append(ChartDataEntry(x: Double(i), y: arrayYaxisString[i]))
        }
        
        let  set1 = LineChartDataSet(entries: yVals, label: "DataSet 1")
        
       
        
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
   
    func setAllValues()
    {
        Constants.arrayXStringValues = arrayxString
        let data1 = dataWithCount()
        data1.setValueFont(UIFont(name: "HelveticaNeue", size: 7)!)
        chartview.backgroundColor = UIColor.white
        setupChart(chartview, data: data1, color: .green)
        
    }
}
