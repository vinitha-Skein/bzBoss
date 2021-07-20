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
    let viewModel = premiseDataViewModel()

   
    let arrayxString = ["12/07", "13/07", "14/07", "15/07", "16/07","17/07","18/07"]
    var dateString = [String()]
    let arrayYAxis = ["11.02 AM","01:50 pm" ,"04:36 pm", "07.23 pm"]
    
    var selectedDate = "12-06-2021"
    var staffCount = [Float()]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collectionview.delegate = self
        collectionview.dataSource = self
        
        
        
       apiCall()
    }
    

    @IBAction func backbuttonpressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func companyDetailsPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main1", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CompanyDetailsViewController") as! CompanyDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
    func setupChart(_ chart: LineChartView, data: LineChartData, color: UIColor)
    {
        print("Date inside",dateString)
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
        let yVals = ChartDataEntry(x: 0.0, y: Double(staffCount[0]))
        let yval2 = ChartDataEntry(x:1.0,y:Double(staffCount[1]))
        let yval3 = ChartDataEntry(x:2.0,y:Double(staffCount[2]))
        let yval4 = ChartDataEntry(x:3.0,y:Double(staffCount[3]))
        let yval5 = ChartDataEntry(x:4.0, y: Double(staffCount[4]))
        let yval6 = ChartDataEntry(x:4.0, y: Double(staffCount[5]))
        let yval7 = ChartDataEntry(x:4.0, y: Double(staffCount[6]))
        
        
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
    
    
    func apiCall()
    {
       
        let params = [
                "startdate": encryptData(str: fromdate()),
                "enddate": encryptData(str: todate()),
                "id": encryptData(str: "4")]
                    print(params)
            
                    viewModel.premiseDatafetch(params: params)
                    viewModel.premiseDatafetchedSuccess =
                    {
                        print("APi called")
                        self.setDatatoVariables()
                    }
            
                    viewModel.loadingStatus =
                    {
                        if self.viewModel.isLoading{
                            //self.activityIndicator(self.view, startAnimate: true)
                        }
                        else
                        {
                            //self.activityIndicator(self.view, startAnimate: false)
                            UIApplication.shared.endIgnoringInteractionEvents()
                        }
                    }
        
    }
    func setDatatoVariables()
    {
        let count = 0...6
        for number in count
        {
            let staff_min = viewModel.premiseData?.premisedailydata![number].number_of_staff_min ?? 0
            let staff_max = viewModel.premiseData?.premisedailydata![number].number_of_staff_max ?? 0
            var staff = Float((staff_min+staff_max)/2)
            staffCount.append(staff)
            var tempDate = viewModel.premiseData?.premisedailydata![number].date ?? "01-01-2020"
            print("Temp date",tempDate)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-d"
            var date1 = dateFormatter.date(from:tempDate)!
            
            
            var dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "dd/MM"
            dateString.append(dateFormatter1.string(from: date1))
        }
        dateString.removeFirst()
        print(dateString)
        let data1 = dataWithCount()
        data1.setValueFont(UIFont(name: "HelveticaNeue", size: 7)!)
        chartView.backgroundColor = UIColor.white
        setupChart(chartView, data: data1, color: .green)

    }

    func fromdate() -> String
    {
        let isoDate = selectedDate
        print(selectedDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
        let date3 = dateFormatter.date(from:isoDate)!
                
        let yesterday = Calendar.current.date(byAdding: .day, value: -7, to: date3)

        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        let prevDate = dateFormatter1.string(from: yesterday!)
        return prevDate

    }
    func todate() -> String
    {
        let isoDate = selectedDate
        print(selectedDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
        let date3 = dateFormatter.date(from:isoDate)!
                
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        let prevDate = dateFormatter1.string(from: date3)
        return prevDate
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
        
        let months: [String]! = variable.arrayxString
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd.MM"
        
        print(variable.dateString)
        return months[Int(value)]
        
    }
    
}

