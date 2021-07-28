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
    
    @IBOutlet weak var staffViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var showStaffDetails: UISwitch!
    
    @IBOutlet weak var statusView: Mybutton!
    @IBOutlet weak var stateandcityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var premiseTitleLabel: UILabel!
    @IBOutlet weak var timingLabel: UILabel!
    
    @IBOutlet weak var chartTitle: UILabel!
    
    @IBOutlet weak var staffDetailsSwitchLabel: UILabel!
    
    
    let viewModel = premiseDataViewModel()
    let staffViewModel = staffDetailsDataViewModel()
    let knownVisitorsModel = KnownVisitorsViewModel()
    var staffSwitchIsOn:Bool =  true
    
    let arrayxString = ["12/07", "13/07", "14/07", "15/07", "16/07","17/07","18/07"]
    var dateString = [String()]
    let arrayYAxis = ["11.02 AM","01:50 pm" ,"04:36 pm", "07.23 pm"]
    
    var selectedDate = "12-06-2021"
    var staffCount = [Float()]
    var staffCountCollectionView = 0
    
    var isfrom = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionview.delegate = self
        collectionview.dataSource = self
        setData()
        apiCall()
        if isfrom == "Staff" {
            getParticularStaffOnDate()
        } else {
            getParticularKnownVisitorsOnDate()
        }
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
    
    
    @IBAction func ShowStaffDetailsChanged(_ sender: UISwitch) {
        if sender.isOn {
            staffSwitchIsOn =  true
            staffViewHeight.constant = 250
            collectionview.isHidden = false
            collectionview.reloadData()
        } else {
            staffSwitchIsOn =  false
            collectionview.isHidden = true
            staffViewHeight.constant = 0
        }
    }
    
    func setupChart(_ chart: LineChartView, data: LineChartData, color: UIColor)
    {
        print("Date inside",dateString)
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
        //        chart.leftAxis.valueFormatter = YAxisNameFormater()
        chart.rightAxis.enabled = false
        chart.xAxis.enabled = true
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelHeight = 21.0
        
        chart.xAxis.valueFormatter = XAxisNameFormater()
        chart.xAxis.labelCount = dateString.count
        chart.xAxis.granularity = 1.0
        chart.data = data
        
        
        let marker = BalloonMarker(color: UIColor(white: 255/255, alpha: 1),
                                           font: .systemFont(ofSize: 12),
                                           textColor: .black,
                                           insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
                marker.chartView = chartView
                marker.minimumSize = CGSize(width: 100, height: 100)
                chartView.marker = marker
        //        chart.animate(xAxisDuration: 2.5)
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
    
    func getParticularStaffOnDate()
    {
        
        let params = [
            "startdate": encryptData(str: fromdate()),
            "enddate": encryptData(str: todate()),
            "id": encryptData(str: "4")]
        print(params)
        
        staffViewModel.premiseDatafetch(params: params)
        staffViewModel.staffDetailsDatafetchedSuccess =
            {
                print("APi called")
                //                self.setDatatoVariables()
                self.staffCountCollectionView = self.staffViewModel.staffDetailsData!.count
                if self.staffSwitchIsOn {
                    self.staffViewHeight.constant = 250
                    self.collectionview.reloadData()
                } else {
                    self.collectionview.isHidden = false
                    self.staffViewHeight.constant = 0
                }
                
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
    func getParticularKnownVisitorsOnDate(){
        
        let params = [
            "startdate": encryptData(str: fromdate()),
            "enddate": encryptData(str: todate()),
            "id": encryptData(str: "4")]
        print(params)
        
        knownVisitorsModel.premiseDatafetch(params: params)
        knownVisitorsModel.KnownVisitorsDatafetchedSuccess =
            {
                print("APi called")
                //                self.setDatatoVariables()
                self.staffCountCollectionView = self.knownVisitorsModel.KnownVisitorsData!.count
                if self.staffSwitchIsOn {
                    self.staffViewHeight.constant = 250
                    self.collectionview.reloadData()
                } else {
                    self.collectionview.isHidden = false
                    self.staffViewHeight.constant = 0
                }
                
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
    func setDatatoVariables()
    {
        let count = 0..<(viewModel.premiseData?.premisedailydata!.count)!
        staffCount.removeAll()
        dateString.removeAll()
        for number in count
        {
            if isfrom == "Staff" {
                let staff_min = viewModel.premiseData?.premisedailydata![number].number_of_staff_min ?? 0
                let staff_max = viewModel.premiseData?.premisedailydata![number].number_of_staff_max ?? 0
                let staff = Float((staff_min+staff_max)/2)
                staffCount.append(staff)
            }
            else if isfrom == "Known Visitors" {
                let staff_min = viewModel.premiseData?.premisedailydata![number].number_of_known_visitors_min ?? 0
                let staff_max = viewModel.premiseData?.premisedailydata![number].number_of_known_visitors_max ?? 0
                let staff = Float((staff_min+staff_max)/2)
                staffCount.append(staff)
            }
            
            let tempDate = viewModel.premiseData?.premisedailydata![number].date ?? "01-01-2020"
            print("Temp date",tempDate)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-d"
            let date1 = dateFormatter.date(from:tempDate)!
            
            
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "dd/MM"
            dateString.append(dateFormatter1.string(from: date1))
        }
        //        dateString.removeFirst()
        print(dateString)
        Constants.arrayXStringValues = dateString
        let data1 = dataWithCount()
        data1.setValueFont(UIFont(name: "HelveticaNeue", size: 7)!)
        chartView.backgroundColor = UIColor.white
        setupChart(chartView, data: data1, color: .green)
        staffCountCollectionView = Int(staffCount[staffCount.count-1])
        
        if isfrom == "Staff" {
            chartTitle.text = "Staff\(Int(staffCount[staffCount.count-1]))"
        } else if isfrom == "Known Visitors" {
            chartTitle.text = "Known Visitors \(Int(staffCount[staffCount.count-1]))"
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
    
    //MARK: Chart Delegate
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        
        print("To Display Values X/Y Values here")
        print(entry.value(forKey: "y")!)
        
        staffCountCollectionView = (entry.value(forKey: "y")!) as! Int
        if staffSwitchIsOn {
            collectionview.reloadData()
        }
        
    }
    
    
    
}

extension StaffDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return staffCountCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "StaffCollectionViewCell", for: indexPath) as! StaffCollectionViewCell
       
        if isfrom == "Staff"{
        let staff = staffViewModel.staffDetailsData?[indexPath.row]
        cell.staffLabel.text = staff?.staff_name
        cell.dateLabel.text = staff?.first_appearance_date_time
        cell.timeLabel.text = ""
        let url = staff?.first_appearance_image
            if url != "" {
        cell.imageViewStaff.af.setImage(withURL: URL(string: url!)! )
            }
        } else {
            let staff = knownVisitorsModel.KnownVisitorsData?[indexPath.row]
            cell.staffLabel.text = staff?.known_visitors_name
            cell.dateLabel.text = staff?.appearance_date_time
            cell.timeLabel.text = ""
//            let url = staff?.appearance_image
//            if url != "" {
//            cell.imageViewStaff.af.setImage(withURL: URL(string: url!)! )
//            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "graphViewController") as! graphViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let height = CGFloat(200)
        let width = (collectionview.frame.width/2) - 20
        return CGSize(width: width, height: height)
    }
}

import Foundation
import Charts

class XAxisNameFormater: NSObject, IAxisValueFormatter {
    
    func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
        //        let variable = StaffDetailsViewController()
        
        let months: [String]! = Constants.arrayXStringValues
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd.MM"
        
        return months[Int(value)]
        
    }
    
}

class YAxisNameFormater: NSObject, IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let date1 = Date(timeIntervalSince1970: TimeInterval(value))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let localDate = dateFormatter.string(from: date1)
        print(localDate)
        return localDate
    }
    
}



