//
//  MaintainTimingViewController.swift
//  bzBoss
//
//  Created by Vinitha on 06/07/21.
//

import UIKit
import Charts

class MaintainTimingViewController: UIViewController, ChartViewDelegate {

    let arrayString = ["12/07", "13/07", "14/07", "15/07", "16/07"]

    @IBOutlet weak var timingLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var isfrom = ""
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var chartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isfrom == "OpenedAt" {
            titleLabel.text = "OPENED AT 11:13 PM"
        } else if isfrom == "FirstCustomer" {
            titleLabel.text = "FIRST CUSTOMER 11:13 PM"
        } else if isfrom == "ClosedAt"{
            titleLabel.text = "CLOSED AT 11:13 PM"
        }
        
        
    }
    
    func setupChart(_ chart: LineChartView, data: LineChartData, color: UIColor) {
        
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
        chart.xAxis.labelCount = arrayString.count
        chart.xAxis.granularity = 1.0
        chart.data = data
        //        chart.animate(xAxisDuration: 2.5)
    }
    
    func dataWithCount() -> LineChartData {
        var set1 = LineChartDataSet()
        if isfrom == "KnownVisitors"{
            let yVals = ChartDataEntry(x: 0.0, y: 0.0)
            let yval2 = ChartDataEntry(x:1.0,y:0.0)
            let yval3 = ChartDataEntry(x:2.0,y:0.0)
            let yval4 = ChartDataEntry(x:3.0,y:5.0)
            let yval5 = ChartDataEntry(x:4.0, y: 4.0)
            set1 = LineChartDataSet(entries: [yVals,yval2,yval3,yval4,yval5], label: "DataSet 1")
        }
        else {
            let yVals = ChartDataEntry(x: 0.0, y: 0.0)
            let yval2 = ChartDataEntry(x:1.0,y:0.0)
            let yval3 = ChartDataEntry(x:2.0,y:0.0)
            let yval4 = ChartDataEntry(x:3.0,y:3.0)
            let yval5 = ChartDataEntry(x:4.0, y:4.0)
            set1 = LineChartDataSet(entries: [yVals,yval2,yval3,yval4,yval5], label: "DataSet 1")
        }
        
        
        
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
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func companydetailsPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main1", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CompanyDetailsViewController") as! CompanyDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func imagePressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "PhotoPreview", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoPreviewViewController") as! PhotoPreviewViewController
        vc.image = imageView.image
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
