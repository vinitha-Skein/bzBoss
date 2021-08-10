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

    @IBOutlet weak var premiseImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    let viewModel = premiseDataViewModel()
    
    var isfrom = ""
    var Time = ""
    var selectedDate = "2021-06-01"
    
    var selectedyValue = "notset"
    var selectedxValue = "notset"

    
    @IBOutlet weak var imageView: UIImageView!
    
    var arrayXaxisString = ["12/07", "13/07", "14/07", "15/07", "16/07"]
    var arrayYaxisString = [Double]()

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
        chart.xAxis.labelCount = arrayXaxisString.count
        chart.xAxis.granularity = 1.0
        chart.data = data
        
       
        //        chart.animate(xAxisDuration: 2.5)
    }
    
    @IBAction func imagepreviewclicked(_ sender: Any) {
        let vc = UIStoryboard.init(name: "PhotoPreview", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoPreviewViewController") as! PhotoPreviewViewController
        vc.image = imageView.image
        present(vc, animated: true, completion: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func dataWithCount() -> LineChartData {
        var set1 = LineChartDataSet()
        if isfrom == "KnownVisitors"{
//            let yVals = ChartDataEntry(x: 0.0, y: 0.0)
//            let yval2 = ChartDataEntry(x:1.0,y:0.0)
//            let yval3 = ChartDataEntry(x:2.0,y:0.0)
//            let yval4 = ChartDataEntry(x:3.0,y:5.0)
//            let yval5 = ChartDataEntry(x:4.0, y: 4.0)
//            set1 = LineChartDataSet(entries: [yVals,yval2,yval3,yval4,yval5], label: "DataSet 1")
        }
        else {
            
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
            
             set1 = LineChartDataSet(entries: yVals, label: "DataSet 1")
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
        present(vc, animated: true, completion: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func imagePressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "PhotoPreview", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoPreviewViewController") as! PhotoPreviewViewController
        vc.image = imageView.image
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func apiCall()
    {
        let id =  UserDefaults.standard.string(forKey: "premiseID")!
        let params = [
                "startdate": encryptData(str: fromdate()),
                "enddate": encryptData(str: todate()),
                "id": encryptData(str: id)]
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
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        let url = UserDefaults.standard.string(forKey: "premiseImage")
        if url != "" {
            premiseImage.backgroundColor = .clear
            premiseImage.af.setImage(withURL: URL(string: url!)! )
        } else {
            premiseImage.backgroundColor = .blue
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

    
    func setDatatoVariables()
    {
        let count = 0..<(viewModel.premiseData?.premisedailydata!.count)!
        arrayYaxisString.removeAll()
        arrayXaxisString.removeAll()
        for number in count
        {
            let date = viewModel.premiseData?.premisedailydata![number].date ?? "01-01-2020"
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-d"
            let date1 = dateFormatter.date(from:date)!
            
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "dd/MM"
           
            if isfrom == "OpenedAt" {
            let openAtTime = viewModel.premiseData?.premisedailydata![number].opened_at ?? "00:00:00"

                if openAtTime != "" && date != "" {
                let dataStr = convertDateToTimeStamp(Convertdate:openAtTime)
                arrayYaxisString.append(Double(dataStr))
                arrayXaxisString.append(dateFormatter1.string(from: date1))
                    
            }
            }
            
            
            else if isfrom == "ClosedAt" {
                let closedAtTime = viewModel.premiseData?.premisedailydata![number].closed_at ?? "00:00:00"
                
                if closedAtTime != "" && date != "" {
                    let dataStr = convertDateToTimeStamp(Convertdate:closedAtTime)
                    arrayYaxisString.append(Double(dataStr))
                    arrayXaxisString.append(dateFormatter1.string(from: date1))
                }
                
            } else if isfrom == "FirstCustomer" {
                let firstCustomerTime = viewModel.premiseData?.premisedailydata![number].first_customer_time ?? "00:00:00"
                
                if firstCustomerTime != "" && date != "" {
                    let dataStr = convertDateToTimeStamp(Convertdate:firstCustomerTime)
                    arrayYaxisString.append(Double(dataStr))
                    arrayXaxisString.append(dateFormatter1.string(from: date1))
                }
            }
           
        }
        print(arrayXaxisString)
        print(arrayYaxisString)
        Constants.arrayXStringValues = arrayXaxisString
       
        let data1 = dataWithCount()
        data1.setValueFont(UIFont(name: "HelveticaNeue", size: 7)!)
        chartView.backgroundColor = UIColor.white
        setupChart(chartView, data: data1, color: .green)
        setImage()
    }
    func setImage() {
        let count = (viewModel.premiseData?.premisedailydata!.count)!
        if isfrom == "OpenedAt" {
            let image = viewModel.premiseData?.premisedailydata![count-1].opened_at_image
            if image != "" {
                imageView.backgroundColor = .clear
                imageView.af.setImage(withURL: URL(string: image!)! )
            } else {
                imageView.backgroundColor = .blue
            }
        } else if isfrom == "FirstCustomer" {
            let image = viewModel.premiseData?.premisedailydata![count-1].first_customer_image
            if image != "" {
                imageView.backgroundColor = .clear
                imageView.af.setImage(withURL: URL(string: image!)! )
            } else {
                imageView.backgroundColor = .blue
            }
        } else if isfrom == "ClosedAt"{
            let image = viewModel.premiseData?.premisedailydata![count-1].opened_at_image
            if image != "" {
                imageView.backgroundColor = .clear
                imageView.af.setImage(withURL: URL(string: image!)! )
            } else {
                imageView.backgroundColor = .blue
            }
        }
    }
    
    
    func convertDateToTimeStamp(Convertdate:String)-> Double{
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="HH:mm:ss"
        let date = dfmatter.date(from: Convertdate)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        let dateSt = Double(dateStamp)
        print("Datastamp",dateSt)
        return dateSt
       
    }
    func setTooltip()
    {
        let marker = BalloonMarker(color: UIColor(white: 245/255, alpha: 1),
                                           font: .systemFont(ofSize: 12),
                                           textColor: .black,
                                           insets: UIEdgeInsets(top: 8, left: 8, bottom:16, right: 8))
                marker.chartView = chartView
        
                marker.minimumSize = CGSize(width: 100, height: 60)
        marker.refreshContent(entry: selectedyValue, highlight: selectedxValue)
                chartView.marker = marker

    }
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        print("To Display Values X/Y Values here")
        print(entry.value(forKey: "y")!)

        let timeResult = entry.y
               let date1 = Date(timeIntervalSince1970: TimeInterval(timeResult))
                   let dateFormatter = DateFormatter()
                   dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                  // dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                   dateFormatter.timeZone = .current
                   let localDate = dateFormatter.string(from: date1)
               selectedyValue = localDate
        
        var xindex = (entry.value(forKey: "x")!) as! Int
        let isoDate = Constants.arrayXStringValues[xindex]
        selectedxValue = dateformatConvert(date: isoDate)

        setTooltip()
    }
    func dateformatConvert(date:String) -> String
    {
        let isoDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        let date3 = dateFormatter.date(from:isoDate)!
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MMMM dd"
        let prevDate = dateFormatter1.string(from: date3)
        print(prevDate)
        return prevDate
    }
    
}

    

