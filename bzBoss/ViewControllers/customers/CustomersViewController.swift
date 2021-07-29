//
//  CustomersViewController.swift
//  bzBoss
//
//  Created by Vinitha on 15/07/21.
//

import UIKit
import Charts

class CustomersViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var statusView: Mybutton!
    @IBOutlet weak var stateandcityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var premiseTitleLabel: UILabel!
    @IBOutlet weak var timingLabel: UILabel!
    
    var arrayXaxisString = ["12/07", "13/07", "14/07", "15/07", "16/07"]
    var isfrom = ""
    var Time = ""
    
    var selectedDate = "2021-06-01"
    let viewModel = premiseDataViewModel()

    @IBOutlet weak var chartTitle: UILabel!
    var staffCount = [Float()]

    override func viewDidLoad() {
        super.viewDidLoad()
        if isfrom == "customers" {
            chartTitle.text = "customers \(Time)"
        }
        setData()
        apiCall()
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

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
            statusView.backgroundColor = UIColor(hexString: Colors.statusgreen)
        }
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
    
   
    
    func setupChart(_ chart: LineChartView, data: LineChartData, color: UIColor) {
        print(staffCount)
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
        chart.leftAxis.axisRange = 1.0
        chart.leftAxis.granularity = 1.0
        chart.rightAxis.enabled = false
        chart.xAxis.enabled = true
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelHeight = 21.0
        
        chart.xAxis.valueFormatter = XAxisNameFormater()
        chart.xAxis.labelCount = arrayXaxisString.count
        chart.xAxis.granularity = 1.0
        chart.data = data
    }
    
    func dataWithCount() -> LineChartData
    {
        var yVals = [ChartDataEntry]()
        
        for i in 0..<staffCount.count {
            yVals.append(ChartDataEntry(x: Double(i), y: Double(staffCount[i])))
        }
        
        let set1 = LineChartDataSet(entries: yVals, label: "DataSet 1")
        
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
    
    func setDatatoVariables()
    {
        let count = 0..<(viewModel.premiseData?.premisedailydata!.count)!
        arrayXaxisString.removeAll()
        staffCount.removeAll()
        for number in count
        {
            let staff_min = viewModel.premiseData?.premisedailydata![number].number_of_customers_min ?? 0
            let staff_max = viewModel.premiseData?.premisedailydata![number].number_of_customers_max ?? 0
            let staff = Float((staff_min+staff_max)/2)
            staffCount.append(staff)
            let tempDate = viewModel.premiseData?.premisedailydata![number].date ?? "01-01-2020"
            print("Temp date",tempDate)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-d"
            let date1 = dateFormatter.date(from:tempDate)!
            
            
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "dd/MM"
            arrayXaxisString.append(dateFormatter1.string(from: date1))
        }
        print(arrayXaxisString)
        print(staffCount)
        chartTitle.text = "customers \(staffCount[staffCount.count-1])"
        Constants.arrayXStringValues = arrayXaxisString
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
