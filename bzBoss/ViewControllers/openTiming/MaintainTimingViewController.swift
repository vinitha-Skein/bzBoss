//
//  MaintainTimingViewController.swift
//  bzBoss
//
//  Created by Vinitha on 06/07/21.
//

import UIKit
import Charts

class MaintainTimingViewController: UIViewController,ChartViewDelegate
{

    @IBOutlet weak var statusView: Mybutton!
    @IBOutlet weak var stateandcityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var premiseTitleLabel: UILabel!
    @IBOutlet weak var timingLabel: UILabel!
    @IBOutlet weak var chartView: LineChartView!

    
    @IBOutlet weak var titleLabel: UILabel!
    let viewModel = premiseDataViewModel()
    
    var isfrom = ""
    var Time = ""
    var selectedDate = "2021-06-01"
    
    @IBOutlet weak var imageView: UIImageView!
    let arrayString = ["12/07", "13/07", "14/07", "15/07", "16/07"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        if isfrom == "OpenedAt" {
            titleLabel.text = "OPENED AT \(Time)"
        } else if isfrom == "FirstCustomer" {
            titleLabel.text = "FIRST CUSTOMER \(Time)"
        } else if isfrom == "ClosedAt"{
            titleLabel.text = "CLOSED AT \(Time)"
        }
        setData()
        apiCall()

        
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
        dismiss(animated: true, completion: nil)
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
                       print( self.viewModel.premiseData?.premisedailydata![0].closed_at)
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
    func setData()
    {
        
        let city = String(UserDefaults.standard.string(forKey: "premiseCity") ??  "")
        let state = String(UserDefaults.standard.string(forKey: "premiseState") ?? "")
        premiseTitleLabel.text = UserDefaults.standard.string(forKey: "premiseTitle")
        
        stateandcityLabel.text = String("\(city), \(state)")
        timeLabel.text = UserDefaults.standard.string(forKey: "premiseDate")
        statusLabel.text = UserDefaults.standard.string(forKey: "premiseStatus")
        timingLabel.text = selectedDate
        
        if(statusLabel.text == "Open")
        {
            statusView.backgroundColor = UIColor.green
        }
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

    

