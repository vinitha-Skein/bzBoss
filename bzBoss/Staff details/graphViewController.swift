//
//  graphViewController.swift
//  bzBoss
//
//  Created by Skeintech on 20/07/21.
//

import UIKit
import Charts
import MonthYearPicker

class graphViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var collchaectioview: UICollectionView!
    let viewModel = IndividualstaffDataViewModel()
    let individualKnownVisitorsViewModel = IndividualKnownVisitorsViewModel()
    
    @IBOutlet weak var chartView: LineChartView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var arrayxString = ["12/07", "13/07", "14/07", "15/07", "16/07","17/07","18/07"]
    var arrayX = ["12/07", "13/07", "14/07", "15/07", "16/07","17/07","18/07"]
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
    
    var isfrom = ""
    @IBOutlet weak var mainView: UIView!
    var arrayYaxisString = [Double]()
    var selectedDate = "12-06-2021"
    var selectedId = ""
    var selectedyValue = String()
    var selectedxValue = String()
    
    @IBOutlet weak var viewDatePopup: UIView!
    
    @IBOutlet weak var datePickerView: MonthYearPickerView!
    
    @IBOutlet weak var titleBarView: UIView!
    
    @IBOutlet weak var DoneButton: Mybutton!
    
    @IBOutlet weak var monthYearLabel: UILabel!
    
    @IBOutlet weak var monthDatePicker: UIButton!
    var pdfURL: URL!
    var pdfDownloadDate = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        collchaectioview.delegate = self
        collchaectioview.dataSource = self
        // Do any additional setup after loading the view.
        if isfrom == "Staff" {
       apiCall()
        } else {
            KnownVisitorsIndividualapiCall()
        }
        selectedIndex = 0
        previousButton.isHidden = true
        print(time1)
        
        viewDatePopup.isHidden = true
        pdfDownloadDate = todate()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer)
    {
        if sender.direction == .right
        {
            if selectedIndex != 0 {
                selectedIndex = selectedIndex-1
            }
            else {
                setStaffData()
            }
            if selectedIndex == 0 {
                previousButton.isHidden = true
            }
           
        }
        
        if sender.direction == .left
        {
            previousButton.isHidden = false
            selectedIndex = selectedIndex+1
            setStaffData()
        }
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
        let id =  UserDefaults.standard.string(forKey: "premiseID")!
        let params =
            [
                "staff_id":encryptData(str: selectedId),
                "enddate": encryptData(str: todate()),
                "premise_id": encryptData(str: id)
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
    
    
    func KnownVisitorsIndividualapiCall()
    {
        activityIndicator(view, startAnimate: true)
        var user_id = String(UserDefaults.standard.integer(forKey: "user_id"))
        let id =  UserDefaults.standard.string(forKey: "premiseID")!
        let params =
            [
                "known_visitors_id":encryptData(str: selectedId),
                "enddate": encryptData(str: todate()),
                "premise_id": encryptData(str: id)
            ]
        print(params)
        individualKnownVisitorsViewModel.individualVisitorsDatafetch(params:params)
        individualKnownVisitorsViewModel.IndividualKnownVisitorsfetchedSuccess =
            {
                
                self.activityIndicator(self.view, startAnimate: false)
                self.StoreKnownVisitorsData()
            }
        viewModel.loadingStatus =
            {
                if self.individualKnownVisitorsViewModel.isLoading{
                    self.activityIndicator(self.view, startAnimate: true)
                }
                else
                {
                    self.activityIndicator(self.view, startAnimate: false)
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            }
        
    }
    
    func StoreKnownVisitorsData() {
        staffCount = individualKnownVisitorsViewModel.IndividualKnownVisitorsdetails?.knownVisitorsData?.count ?? 0
        collchaectioview.reloadData()
        let n = (individualKnownVisitorsViewModel.IndividualKnownVisitorsdetails?.knownVisitorsData?.count)!
        
        let count = 0..<n
        for numbers in count
        {
            let details = (individualKnownVisitorsViewModel.IndividualKnownVisitorsdetails?.knownVisitorsData![numbers])
            var arrayXaxisString = [String]()
            var dateString = [String]()
            var arrayYaxisString = [Double]()
            for number in 0..<(details?.knownvisitorsdata!.count)! {
                
                let date = details?.knownvisitorsdata![number].appearance_date_time ?? "01-01-2020 "
                
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
            let count = (details?.knownvisitorsdata!.count)!
            let image = details?.knownvisitorsdata![count-1].appearance_image ?? ""
            let value1 = individualstaffDetailsLocal(Name: (individualKnownVisitorsViewModel.IndividualKnownVisitorsdetails?.knownVisitorsData![numbers].first_name), Image: (image), arrayXString: arrayXaxisString, arrayYString: arrayYaxisString)
            self.allStaffDetails.append(value1)
            
        }
        
        print(allStaffDetails.count)
        print(allStaffDetails)
        setStaffData()
    }
    
   func storeDatatoArray()
   {
    staffCount = viewModel.individualstaffdetails?.staffDetailsData?.count ?? 0
    collchaectioview.reloadData()
    let n = (viewModel.individualstaffdetails?.staffDetailsData!.count)!
    arrayX.removeAll()
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
            arrayX.append(openAtTime[0])
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
        let count = (details?.staffdata!.count)!
         let image = details?.staffdata![count-1].first_appearance_image ?? ""
        let value1 = individualstaffDetailsLocal(Name: (viewModel.individualstaffdetails?.staffDetailsData![numbers].first_name), Image: (image), arrayXString: arrayXaxisString, arrayYString: arrayYaxisString)
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
        let replace = url!.replacingOccurrences(of: " ", with: "%20")
        if replace != "" {
            imageView.af.setImage(withURL: URL(string: replace)! )
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
        
        chart.leftAxis.labelTextColor = .black
        chart.xAxis.labelTextColor = .black
        
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
        
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MMMM yyyy"
        monthYearLabel.text = dateFormatter2.string(from: date3)
        
        return prevDate
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
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        
        print("To Display Values X/Y Values here")
        let xindex = (entry.value(forKey: "x")!) as! Int
        let isoDate = Constants.arrayXStringValues[xindex]
        selectedxValue = dateformatConvert(date: isoDate)
        
        selectedDate = dateforSelectedDate(date: arrayX[xindex])
        
        let timeResult = entry.y
        let date1 = Date(timeIntervalSince1970: TimeInterval(timeResult))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        // dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date1)
        
        selectedyValue = localDate
        
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
    
    func dateforSelectedDate(date:String) -> String
    {
        let isoDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-d"
        let date3 = dateFormatter.date(from:isoDate)!
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "EEEE, MMMM d, yyyy"
        let prevDate = dateFormatter1.string(from: date3)
        print(prevDate)
        return prevDate
        
    }
    
    
    @IBAction func monthDatePickerPressed(_ sender: Any) {
        datePickerView.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        viewDatePopup.isHidden = false
    }
    
    
    
    @IBAction func DownloadPdfPressed(_ sender: Any) {
        self.activityIndicator(self.view, startAnimate: true)
        let id =  UserDefaults.standard.string(forKey: "premiseID")!
        guard let url = URL(string: "https://theadeptz.com/bzBoss/public/api/user/pdfgraph?premise_id=\(id)&date=\(pdfDownloadDate)&type=Ind-cust") else { return }
        
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
        
    }
    
    @IBAction func DoneButtonpressed(_ sender: Any) {
        print(datePickerView.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        pdfDownloadDate = dateFormatter.string(from: datePickerView.date)
        print(pdfDownloadDate)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MMMM yyyy"
        monthYearLabel.text = dateFormatter1.string(from: datePickerView.date)
        print(monthYearLabel.text)
        viewDatePopup.isHidden = true
    }
    
    @objc func dateChanged(_ picker: MonthYearPickerView) {
        
        
    }
    func showDownloaded() {
        let alert = UIAlertController.init(title: nil, message: "PDF Download Complete", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "View", style: .default, handler: { (action) in
            
            let storyboard = UIStoryboard(name: "Main1", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PDFViewController") as! PDFViewController
            vc.modalPresentationStyle = .fullScreen
            vc.pdfURL = self.pdfURL
            self.present(vc, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Share", style: .cancel, handler: { (action) in
            var filesToShare = [Any]()
            filesToShare.append(self.pdfURL as Any)
            let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
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


extension graphViewController:  URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent("pdfGraph.pdf")
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            
            self.pdfURL = destinationURL
            DispatchQueue.main.async {
                self.activityIndicator(self.view, startAnimate: false)
                UIApplication.shared.endIgnoringInteractionEvents()
                self.showDownloaded()
            }
            
            
        } catch let error {
            self.activityIndicator(self.view, startAnimate: false)
            UIApplication.shared.endIgnoringInteractionEvents()
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}

