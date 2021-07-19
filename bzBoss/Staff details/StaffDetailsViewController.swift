//
//  StaffDetailsViewController.swift
//  bzBoss
//
//  Created by Skeintech on 06/07/21.
//

import UIKit
import Charts

class StaffDetailsViewController: UIViewController, ChartViewDelegate
{
    @IBOutlet weak var collectionview: UICollectionView!
    var staffs = ["Staff 1","Staff 2","Staff 3","Staff 4"]
    
    @IBOutlet weak var chartView: LineChartView!
    let arrayString = ["12/07", "13/07", "14/07", "15/07", "16/07"]
    let arrayYAxis = ["11.02 AM","01:50 pm" ,"04:36 pm", "07.23 pm"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collectionview.delegate = self
        collectionview.dataSource = self
        let data1 = dataWithCount()
        data1.setValueFont(UIFont(name: "HelveticaNeue", size: 7)!)
        chartView.backgroundColor = UIColor.white
        setupChart(chartView, data: data1, color: .green)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backbuttonpressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func companyDetailsPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main1", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CompanyDetailsViewController") as! CompanyDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
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
        let yVals = ChartDataEntry(x: 0.0, y: 0.0)
        let yval2 = ChartDataEntry(x:1.0,y:0.0)
        let yval3 = ChartDataEntry(x:2.0,y:0.0)
        let yval4 = ChartDataEntry(x:3.0,y:2.0)
        let yval5 = ChartDataEntry(x:4.0, y: 4.0)
        
        
        let set1 = LineChartDataSet(entries: [yVals,yval2,yval3,yval4,yval5], label: "DataSet 1")
        
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
    

    
}

extension StaffDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return staffs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "StaffCollectionViewCell", for: indexPath) as! StaffCollectionViewCell
        cell.staffLabel.text = staffs[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "IndividualStaffViewController") as! IndividualStaffViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let height = collectionview.frame.height-10
        let width = (collectionview.frame.width/2) - 20
        return CGSize(width: 30, height: height)
    }
}

import Foundation
import Charts

class XAxisNameFormater: NSObject, IAxisValueFormatter {
    
    func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
        let variable = StaffDetailsViewController()
        
        let months: [String]! = variable.arrayString
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd.MM"
        
        return months[Int(value)]
        
    }
    
}

