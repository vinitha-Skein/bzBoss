//
//  graphViewController.swift
//  bzBoss
//
//  Created by Skeintech on 20/07/21.
//

import UIKit
import Charts

class graphViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var collchaectioview: UICollectionView!
    let viewModel = IndividualstaffDataViewModel()
    
    @IBOutlet weak var chartView: LineChartView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var arrayxString = ["12/07", "13/07", "14/07", "15/07", "16/07","17/07","18/07"]
    var value1 = [0,0,0,0,0,0,0]
    var value2 = [0,0,0,0,0,0,0]
    var value3 = [0,0,1,0,0,1,0]
    var value4 = [1,1,1,1,1,1,1]
    var value5 = [0,0,0,1,0,0,0]
    var value6 = [0,0,0,0,1,0,0]
    var value7 = [0,0,0,0,0,0,0]
    //var time1 = [[String]]()
    var time1: [String] = []
    var time2 = [String]()
    var time3 = [String]()
    var time4 = [String]()
    var time5 = [String]()
    var time6 = [String]()
    var time7 = [String]()
    var staffCount = 1
     var allStaffDetails = [individualstaffDetailsLocal]()

    @IBOutlet weak var previousButton: Mybutton!
    var selectedIndex = 0
    
    @IBOutlet weak var NextButton: UIButton!
    
    @IBOutlet weak var GraphTitleLabel: UILabel!
    var arrayYaxisString = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collchaectioview.delegate = self
        collchaectioview.dataSource = self
        // Do any additional setup after loading the view.
       apiCall()
        selectedIndex = 0
        previousButton.isHidden = true
        print(time1)
    }
    @IBAction func back_pressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func previousButtonPressed(_ sender: Any) {
        if selectedIndex != 0 {
        selectedIndex = selectedIndex-1
        }
        if selectedIndex == 0 {
            previousButton.isHidden = true
        }
        setStaffData()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
            previousButton.isHidden = false
            selectedIndex = selectedIndex+1
            setStaffData()
    }
    
    func apiCall()
    {
        activityIndicator(view, startAnimate: true)
        var user_id = String(UserDefaults.standard.integer(forKey: "user_id"))
        let params =
            [
                "staff_id":"YVg2b0xYZTQvYzhKU3NEWjdyOGZzQT09",
                "startdate": "cUd5YTQrSmxaVHRsOE5WV2p3dk9Cdz09",
                "enddate": "RnFoTDR3bE9LUVA4a1lpMmpYSDl5Zz09",
                "premise_id": "K1FWc1IxcmNUdSs5S3VaSTkxNnEyQT09"
            ]
        print(params)
        viewModel.individualstaffDatafetch(params:params)
        viewModel.individualstafffetchedSuccess =
            {

                self.activityIndicator(self.view, startAnimate: false)
                self.storeDatatoArray()
        }
        viewModel.loadingStatus =
        {
            if self.viewModel.isLoading{
                self.activityIndicator(self.view, startAnimate: true)
            }
            else
            {
                self.activityIndicator(self.view, startAnimate: false)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
    
    }
    
    
   func storeDatatoArray()
   {
    staffCount = viewModel.individualstaffdetails?.staffDetailsData?.count ?? 0
    collchaectioview.reloadData()
    let n = (viewModel.individualstaffdetails?.staffDetailsData!.count)!
   
    let count = 0..<n
    for numbers in count
    {
        let details = (viewModel.individualstaffdetails?.staffDetailsData![numbers])
        var arrayXaxisString = [String]()
        var dateString = [String]()
        var arrayYaxisString = [Double]()
        for number in 0..<(details?.staffdata!.count)! {
           
            let date = details?.staffdata![number].first_appearance_date_time ?? "01-01-2020 "
            
                let openAtTime = date.components(separatedBy:[" "])
                
                if openAtTime[1] != "" && date != "" {
                    let dataStr = convertDateToTimeStamp(Convertdate:openAtTime[1])
                    arrayYaxisString.append(Double(dataStr))
            }
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-d HH:mm:ss"
            let date1 = dateFormatter.date(from:date)!
            
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "dd/MM"
            arrayXaxisString.append(dateFormatter1.string(from: date1))
            dateString.append(dateFormatter1.string(from: date1))
            
        }
        print(arrayXaxisString)
        print(arrayYaxisString)
        let value1 = individualstaffDetailsLocal(Name: (viewModel.individualstaffdetails?.staffDetailsData![numbers].first_name), Image: (viewModel.individualstaffdetails?.staffDetailsData![numbers].photo), arrayXString: arrayXaxisString, arrayYString: arrayYaxisString )
        self.allStaffDetails.append(value1)
        
    }
    print(allStaffDetails.count)
    print(allStaffDetails)
    setStaffData()
    collchaectioview.reloadData()
   }
    func setStaffData()
    {
        if selectedIndex >= 0 && selectedIndex <= allStaffDetails.count-1{
            NextButton.isHidden = false
            previousButton.isHidden = false
        }
        
        if selectedIndex >= allStaffDetails.count-1 {
            NextButton.isHidden = true
        }
        if selectedIndex <= 0 {
            previousButton.isHidden = true
        }
       
        GraphTitleLabel.text = allStaffDetails[selectedIndex].Name
        arrayxString = allStaffDetails[selectedIndex].arrayXString
        arrayYaxisString = allStaffDetails[selectedIndex].arrayYString
        let url = allStaffDetails[selectedIndex].Image
        if url != "" {
            imageView.af.setImage(withURL: URL(string: url!)! )
        }
        setAllValues()
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
        
//        yVals.append((ChartDataEntry(x: 2.0, y: 0.0)))
       
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
//        arrayxString.append("")
        Constants.arrayXStringValues = arrayxString
        let data1 = dataWithCount()
        data1.setValueFont(UIFont(name: "HelveticaNeue", size: 7)!)
        chartView.backgroundColor = UIColor.white
        setupChart(chartView, data: data1, color: .green)
        
    }
    
    func converttoTime(time: String) ->  String
    {   let tempDate = time
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-d HH:mm:ss"
        let date1 = dateFormatter.date(from:tempDate)!
        
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "HH:mm:ss"
        return convertto12(time:dateFormatter1.string(from: date1))
    }
    func convertto12(time: String) -> String
    {
        let dateAsString = time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "h:mm a"
        if(date != nil)
        {
            let Date12 = dateFormatter.string(from: date!)
            print("12 hour formatted Date:",Date12)
            return Date12
        }
        return "-"
    }

}
extension graphViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.individualstaffdetails != nil {
            return allStaffDetails.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCollectionViewCell", for: indexPath) as! testCollectionViewCell
        cell.staffLabel.text = allStaffDetails[indexPath.row].Name
        cell.arrayxString = allStaffDetails[indexPath.row].arrayXString
        cell.arrayYaxisString = allStaffDetails[indexPath.row].arrayYString
        cell.setAllValues()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collchaectioview.frame.width, height: collchaectioview.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
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
    
}
