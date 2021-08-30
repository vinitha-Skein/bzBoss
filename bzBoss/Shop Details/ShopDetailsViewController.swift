//
//  ShopDetailsViewController.swift
//  bzBoss
//
//  Created by Skeintech on 01/07/21.
//

import UIKit
import BEMAnalogClock
import iOSDropDown
import PKHUD

class ShopDetailsViewController: UIViewController
{
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var graphicalView: UIView!
    @IBOutlet weak var viewSwitch: UISwitch!
    @IBOutlet weak var statusView: Mybutton!
    @IBOutlet weak var visitorsLabel: UILabel!
    @IBOutlet weak var visitorsTarget: DropDown!
    @IBOutlet weak var staffTarget: DropDown!
    @IBOutlet weak var staffLabel: UILabel!
    @IBOutlet weak var customersTarget: DropDown!
    @IBOutlet weak var cuctomersLabel: UILabel!
    @IBOutlet weak var closedAtTimeLabel: UILabel!
    @IBOutlet weak var firstCustomerTimeLabel: UILabel!
    @IBOutlet weak var openedAtTimeLabel: UILabel!
    @IBOutlet weak var dateandTimeLabel: UILabel!
    @IBOutlet weak var premiseImage: UIImageView!
    @IBOutlet weak var premiseStateLabel: UILabel!
    @IBOutlet weak var premiseCityLabel: UILabel!
    @IBOutlet weak var premiseTitle: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var visitorsChartView: UIView!
    @IBOutlet weak var closedatView: UIView!
    @IBOutlet weak var staffChartView: UIView!
    @IBOutlet weak var customersChartView: UIView!
    @IBOutlet weak var firstCustomerView: UIView!
    @IBOutlet weak var openedatView: UIView!
    //@IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var knownVistorsChart: DonutView!
    @IBOutlet weak var staffsChart: DonutView!
    @IBOutlet weak var customersChart: DonutView!
    @IBOutlet var closedatClock: BEMAnalogClockView!
    @IBOutlet weak var firstCustomerClock: BEMAnalogClockView!
    @IBOutlet weak var openedatClock: BEMAnalogClockView!
    @IBOutlet var dateLabel: UILabel!
//    @IBOutlet var graphicalButton: Mybutton!
//    @IBOutlet var numericalButton: Mybutton!
    @IBOutlet var calenderView: UIView!
    @IBOutlet var yesterdayButton: Mybutton!
    @IBOutlet var collectionview: UICollectionView!
    @IBOutlet var todayButton: Mybutton!
    let viewModel = ShopdetailsViewModel()
    let userViewModel = SignInViewModel()
    
    var dateSelectionBG = UIColor(red: 195/255, green: 250/255, blue: 255/255, alpha: 1)
    var selectedColor = UIColor(red: 29/255, green: 138/255, blue: 254/255, alpha: 1)
    
    var toggleSelected = String()
    var openedat = String()
    var closedat = String()
    var firstcustomer = String()
    var customers = Int()
    var staff = Int()
    var knownVisitors = Int()
    var toggle = String()
    var premiseImagevalue = String()
    var firstcusHour = Int()
    var firstcusmin = Int()
    var firstLoad = true
    var premiseID = UserDefaults.standard.string(forKey: "premiseID")
    var selectedDate = String()
    var userSelectedDate = "2021-06-08"
    
    var category = ["OPENED AT","FIRST CUSTOMER","CUSTOMERS","STAFF","CLOSED AT","KNOWN VISITORS"]
//    var green1 = UIColor(red: 76/255, green: 192/255, blue: 166/255, alpha: 1)
//    var orange = UIColor(red: 243/255, green: 118/255, blue: 108/255, alpha: 1)
//    var blue = UIColor(red: 119/255, green: 177/255, blue: 223/255, alpha: 1)
//    var violet = UIColor(red: 166/255, green: 148/255, blue: 232/255, alpha: 1)

    var bgColors = [UIColor(red: 76/255, green: 192/255, blue: 166/255, alpha: 1),UIColor(red: 243/255, green: 118/255, blue: 108/255, alpha: 1),UIColor(red: 119/255, green: 177/255, blue: 223/255, alpha: 1),UIColor(red: 166/255, green: 148/255, blue: 232/255, alpha: 1),UIColor(red: 232/255, green: 158/255, blue: 82/255, alpha: 1),UIColor(red: 200/255, green: 132/255, blue: 140/255, alpha: 1)]
    
    @IBOutlet weak var collectionViewGrpahical: UICollectionView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //viewSwitch.addTarget(self, action: #selector(pressed), for: .valueChanged)
        collectionview.delegate = self
        collectionview.dataSource = self
        setUpUI()
        apiCall()
        clockchange()
        viewAction()

        collectionViewGrpahical.register(UINib(nibName: "TimingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimingCollectionViewCell")
        collectionViewGrpahical.register(UINib(nibName: "PersonsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PersonsCollectionViewCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func viewAction()
    {
        let openedGesture = UITapGestureRecognizer(target: self, action:  #selector(self.openedAction))
        self.openedatView.addGestureRecognizer(openedGesture)
        let closedGesture = UITapGestureRecognizer(target: self, action:  #selector(self.closedAction))
        self.closedatView.addGestureRecognizer(closedGesture)
        let firstCusGesture = UITapGestureRecognizer(target: self, action:  #selector(self.firstCusAction))
        self.firstCustomerView.addGestureRecognizer(firstCusGesture)
        let customerGesture = UITapGestureRecognizer(target: self, action:  #selector(self.customerAction))
        self.customersChartView.addGestureRecognizer(customerGesture)
        let staffGesture = UITapGestureRecognizer(target: self, action:  #selector(self.staffAction))
        self.staffChartView.addGestureRecognizer(staffGesture)
        let visitorsGesture = UITapGestureRecognizer(target: self, action:  #selector(self.visitorsAction))
        self.visitorsChartView.addGestureRecognizer(visitorsGesture)
    }
    @objc func openedAction(sender : UITapGestureRecognizer)
    {
        if openedat != "" {
            gotomaintainTimingViewController(Str: "OpenedAt",time: convertto12(time: openedat))
        } else {
            HUD.flash(.label("No data available"), delay: 2.0)
        }
    }
    @objc func closedAction(sender : UITapGestureRecognizer)
    {
        if closedat != "" {
            gotomaintainTimingViewController(Str: "ClosedAt",time: convertto12(time: closedat))
        } else {
            HUD.flash(.label("No data available"), delay: 2.0)
        }
    }
    @objc func firstCusAction(sender : UITapGestureRecognizer)
    {
        if firstcustomer != "" {
            gotomaintainTimingViewController(Str: "FirstCustomer",time: convertto12(time: firstcustomer))
        } else {
            HUD.flash(.label("No data available"), delay: 2.0)
        }
    }
    @objc func customerAction(sender : UITapGestureRecognizer)
    {
        if customers != 0 {
            gotoCustomersView(Str: "customers",time: convertto12(time: "\(customers)"))
        } else {
            HUD.flash(.label("No data available"), delay: 2.0)
        }
    }
    @objc func staffAction(sender : UITapGestureRecognizer)
    {
        if staff != 0 {
            gotoStaffDetails(str: "Staff")
        } else {
            HUD.flash(.label("No data available"), delay: 2.0)
        }
    }
    @objc func visitorsAction(sender : UITapGestureRecognizer)
    {
        if knownVisitors != 0 {
            gotoStaffDetails(str: "Known Visitors")
        } else {
            HUD.flash(.label("No data available"), delay: 2.0)
        }
    }
    
    public func clockchange()
    {
        
        firstCustomerClock.hours = Int(converttohour(time: firstcustomer)) ?? 12
        firstCustomerClock.minutes = Int(converttominute(time: firstcustomer)) ?? 12
        firstCustomerClock.reloadClock()
        
        openedatClock.hours = Int(converttohour(time: openedat)) ?? 12
        openedatClock.minutes = Int(converttominute(time: openedat)) ?? 12
        openedatClock.reloadClock()
        
        closedatClock.hours = Int(converttohour(time: closedat)) ?? 12
        closedatClock.minutes = Int(converttominute(time: closedat)) ?? 12
        closedatClock.reloadClock()
        
        var check = Int(converttohour(time: openedat))
        print("checking data \(check)")
    }
    func customersgraph(target: String)
    {
        customersChart.goal = Int(target) ?? 10
        customersChart.progress = customers
        customersChart.reloadInputViews()
    }
    func staffsgraph(target: String)
    {
        staffsChart.goal = Int(target) ?? 10
        staffsChart.progress = staff
        customersChart.reloadInputViews()
    }
    func visitorsgraph(target: String)
    {
        knownVistorsChart.goal = Int(target) ?? 10
        knownVistorsChart.progress = knownVisitors
        customersChart.reloadInputViews()
    }
    func apiCall()  {
        firstLoad = false
        activityIndicator(view, startAnimate: true)
        var user_id = String(UserDefaults.standard.integer(forKey: "user_id"))
        
        let params =
            [
                "date": encryptData(str: selectedDate),
                "id": encryptData(str: String(premiseID ?? "4")),
                "user_id": encryptData(str: user_id)
            ]
        print(params)
        viewModel.shopDetail(params: params)
        viewModel.shopdetailsfetchedSuccess =
            { [self] in
                self.activityIndicator(self.view, startAnimate: false)
                self.setDatatoVariables()
                self.filldata()
                self.setUserPremise()
                self.collectionview.reloadData()
                print(self.viewModel.shopdetailsData?.userpremise?.opened_at)
            //UserDefaults.standard.set(true, forKey: "isLoggedIn"
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
    func setUserPremise() {
        category.removeAll()
        bgColors.removeAll()
        
        if self.viewModel.shopdetailsData?.userpremise?.opened_at! == "True" {
            category.append("OPENED AT")
            bgColors.append(UIColor(red: 76/255, green: 192/255, blue: 166/255, alpha: 1))
        }
        if self.viewModel.shopdetailsData?.userpremise?.first_customer! == "True" {
            category.append("FIRST CUSTOMER")
            bgColors.append(UIColor(red: 243/255, green: 118/255, blue: 108/255, alpha: 1))
        }
        if self.viewModel.shopdetailsData?.userpremise?.customer! == "True" {
            category.append("CUSTOMERS")
            bgColors.append(UIColor(red: 119/255, green: 177/255, blue: 223/255, alpha: 1))
        }
        if self.viewModel.shopdetailsData?.userpremise?.staff! == "True" {
            category.append("STAFF")
            bgColors.append(UIColor(red: 166/255, green: 148/255, blue: 232/255, alpha: 1))
        }
        if self.viewModel.shopdetailsData?.userpremise?.closed_at! == "True" {
            category.append("CLOSED AT")
            bgColors.append(UIColor(red: 232/255, green: 158/255, blue: 82/255, alpha: 1))
        }
        if self.viewModel.shopdetailsData?.userpremise?.visitors! == "True" {
            category.append("KNOWN VISITORS")
            bgColors.append(UIColor(red: 200/255, green: 132/255, blue: 140/255, alpha: 1))
        }
        collectionview.reloadData()
    }
    func userConfigApi()
    {
        let dateselected = selectedDate
        let targertstaff = String(staffTarget.text!)
        let targetcus = String(customersTarget.text!)
        let targetknown = String(visitorsTarget.text!)
        let usertoggle = toggleSelected
        let premiseid = String(premiseID ?? "4")
        let userid = String(UserDefaults.standard.integer(forKey: "user_id"))
        
        let params = [
        "user_id":encryptData(str: userid),
        "premise_id":encryptData(str: premiseid),
        "date":encryptData(str: dateselected),
        "toggle":encryptData(str: usertoggle),
        "targetstaff":encryptData(str: targertstaff),
        "targetcust":encryptData(str: targetcus),
        "targetknown":encryptData(str: targetknown)]
        viewModel.userConfig(params: params)
        print(params)
        viewModel.userConfigstatus =
        {
            if self.viewModel.userConfigUpdated
            {
                self.activityIndicator(self.view, startAnimate: false)
                self.apiCall()
            }
            else
            {
                self.activityIndicator(self.view, startAnimate: false)
                UIApplication.shared.endIgnoringInteractionEvents()
                print("Changes not updated in server")
            }
        }
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
    func converttohour(time: String) -> String
    {
        let dateAsString = time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "h"
        if(date != nil)
        {
            let Date12 = dateFormatter.string(from: date!)
            print("12 hour formatted Date:",Date12)
            return Date12
        }
        return "12"
    }
    func converttominute(time: String) -> String
    {
        let dateAsString = time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "mm"
        if(date != nil)
        {
            let Date12 = dateFormatter.string(from: date!)
            print("12 hour formatted Date:",Date12)
            return Date12
        }
        return "0"
    }
    func setDatatoVariables()
    {
        self.openedat = self.viewModel.shopdetailsData?.opened_at ?? "-"
        self.closedat = self.viewModel.shopdetailsData?.closed_at ?? "-"
        self.firstcustomer = self.viewModel.shopdetailsData?.first_customer_time ?? "-"
        self.customers = (self.viewModel.shopdetailsData?.number_of_customersnumber)!
        self.toggle = self.viewModel.shopdetailsData?.userconfigdata?.toggle ?? "graphic"
        self.userSelectedDate = self.viewModel.shopdetailsData?.userconfigdata?.date ?? "2021-06-08"

        self.premiseImagevalue = self.viewModel.shopdetailsData?.premisedata?.photo ?? ""
        
       if (viewModel.shopdetailsData?.number_of_known_visitors_max != nil && viewModel.shopdetailsData?.number_of_known_visitors_min != nil)
       {
        let visitors_min = Int((viewModel.shopdetailsData?.number_of_known_visitors_min)!)
        let visitors_max = Int((viewModel.shopdetailsData?.number_of_known_visitors_max)!)
        self.knownVisitors = (visitors_min+visitors_max)/2
       }
        
        if (viewModel.shopdetailsData?.number_of_customers_max != nil && viewModel.shopdetailsData?.number_of_customers_min != nil)
        {
         let customers_min = Int((viewModel.shopdetailsData?.number_of_customers_min)!)
         let customers_max = Int((viewModel.shopdetailsData?.number_of_customers_max)!)
         self.customers = (customers_min+customers_max)/2
        }
        if (viewModel.shopdetailsData?.number_of_staff_max != nil && viewModel.shopdetailsData?.number_of_staff_min != nil)
        {
         let staffs_min = Int((viewModel.shopdetailsData?.number_of_staff_min)!)
         let staffs_max = Int((viewModel.shopdetailsData?.number_of_staff_max)!)
         self.staff = (staffs_min+staffs_max)/2
            
        }
        
        staffLabel.text = "\(staff)"
        cuctomersLabel.text = "\(customers)"
        visitorsLabel.text = "\(knownVisitors)"
       

    }
    func filldata()
    {
        //viewDidLoad()
        clockchange()
        premiseTitle.text = viewModel.shopdetailsData?.premisedata?.name
        premiseCityLabel.text = viewModel.shopdetailsData?.premisedata?.city
        premiseStateLabel.text = viewModel.shopdetailsData?.premisedata?.state
        dateandTimeLabel.text = viewModel.shopdetailsData?.getcurrentstatus?.last_updated
        statusLabel.text = viewModel.shopdetailsData?.getcurrentstatus?.status
        openedAtTimeLabel.text = convertto12(time: openedat)
        firstCustomerTimeLabel.text = convertto12(time: firstcustomer)
        closedAtTimeLabel.text = convertto12(time: closedat)
        staffTarget.text = viewModel.shopdetailsData?.userconfigdata?.targetstaff ?? "20"
        customersTarget.text = viewModel.shopdetailsData?.userconfigdata?.targetcust ?? "20"
        visitorsTarget.text = viewModel.shopdetailsData?.userconfigdata?.targetknown ?? "20"
        
        

        UserDefaults.standard.setValue(viewModel.shopdetailsData?.premisedata?.name ?? "Prince Complex", forKey: "premiseTitle")
        UserDefaults.standard.setValue(viewModel.shopdetailsData?.premisedata?.city ?? "Chennai", forKey: "premiseCity")
        UserDefaults.standard.setValue(viewModel.shopdetailsData?.premisedata?.state  ?? "Tamilnadu", forKey: "premiseState" )
        UserDefaults.standard.setValue(viewModel.shopdetailsData?.getcurrentstatus?.last_updated ?? "12-07-2021", forKey: "premiseDate")
        UserDefaults.standard.setValue(viewModel.shopdetailsData?.getcurrentstatus?.status ?? "Open", forKey: "premiseStatus")
        UserDefaults.standard.setValue(viewModel.shopdetailsData?.getcurrentstatus?.image_filename, forKey: "premiseImage")
        
        let url = viewModel.shopdetailsData?.getcurrentstatus?.image_filename
        let replace = url!.replacingOccurrences(of: " ", with: "%20")
        premiseImage.af.setImage(withURL: URL(string: replace)! )
        
        staffsgraph(target: staffTarget.text ?? "10")
        customersgraph(target: customersTarget.text ?? "10")
        visitorsgraph(target: visitorsTarget.text ?? "10")
        
        if(statusLabel.text == "Open")
        {
            statusView.backgroundColor = UIColor(hexString: Colors.statusgreen)
        }
        if firstLoad == true
        {
            if (toggle == "graphic")
                {
                    graphicalUI()
            
                }
            else
            {
                numericalUI()
            }
        }
//            setImage(from: premiseImagevalue)

        
    }
    @IBAction func ViewChanged(_ sender: UISwitch) {
        if sender.isOn
        {
            graphical_Clicked()
        } else
        {
            numerical_Clicked()
        }
    }
    func setUpUI()
    {
        customersChart.rotate(degrees: 180)
        staffsChart.rotate(degrees: 180)
        knownVistorsChart.rotate(degrees: 180)
        viewSwitch.layer.cornerRadius = 14
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
        //firstCustomerView.layer.borderColor = UIColor.black.cgColor
        firstCustomerView.layer.borderWidth = 0.5
        firstCustomerView.layer.cornerRadius = 5
        //customersChartView.layer.borderColor = UIColor.black.cgColor
        customersChartView.layer.borderWidth = 0.5
        customersChartView.layer.cornerRadius = 5
        //staffChartView.layer.borderColor = UIColor.black.cgColor
        staffChartView.layer.borderWidth = 0.5
        staffChartView.layer.cornerRadius = 5
        //closedatView.layer.borderColor = UIColor.black.cgColor
        closedatView.layer.borderWidth = 0.5
        closedatView.layer.cornerRadius = 5
        //visitorsChartView.layer.borderColor = UIColor.black.cgColor
        visitorsChartView.layer.borderWidth = 0.5
        visitorsChartView.layer.cornerRadius = 5
        //scrollView.isHidden = true
        graphicalView.isHidden = true
        viewHeight.constant = 860
        //openedatView.layer.borderColor = UIColor.black.cgColor
        openedatView.layer.borderWidth = 0.5
        openedatView.layer.cornerRadius = 5
        selectedDate = todaysDate()
        dateLabel.text = selectedDate
        print("Selected Date",selectedDate)
        
        
        
        
        staffTarget.optionArray = ["1", "2", "3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50"]
        visitorsTarget.optionArray = ["1", "2", "3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50"]
        customersTarget.optionArray = ["20", "50", "100","150","200","250","300","350","400","450","500","550","600","650","700","750","800","850","900","950","1000"]
        staffTarget.didSelect{(selectedText , index ,id) in
              var staffselected = "Selected String: \(selectedText) \n index: \(index)"
            print(staffselected)
            self.staffTarget.text = selectedText
            self.staffsgraph(target: selectedText)
            print(self.staffTarget.text)
            self.userConfigApi()
               }
        customersTarget.didSelect{(selectedText , index ,id) in
              var staffselected = "Selected String: \(selectedText) \n index: \(index)"
            print(staffselected)
            self.customersTarget.text = selectedText
            self.customersgraph(target: selectedText)
            self.userConfigApi()
               }
        visitorsTarget.didSelect{(selectedText , index ,id) in
              var staffselected = "Selected String: \(selectedText) \n index: \(index)"
            print(staffselected)
            self.visitorsTarget.text = selectedText
            self.visitorsgraph(target: selectedText)
            self.userConfigApi()

               }
    }
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async
        {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.premiseImage.image = image
            }
        }
    }
    func numerical_Clicked()
    
    {
        userConfigApi()
        numericalUI()
        toggleSelected = "numeric"
    }
    
    
    func graphical_Clicked()
    {
        userConfigApi()
        graphicalUI()
        toggleSelected = "graphic"
    }
    @IBAction func refresh_clicked(_ sender: Any)
    {
        apiCall()
    }
    @IBAction func today_Clicked(_ sender: Any)
    {
        userConfigApi()
        yesterdayButton.layer.backgroundColor = dateSelectionBG.cgColor
        yesterdayButton.setTitleColor(UIColor.black, for: .normal)
        todayButton.layer.backgroundColor = selectedColor.cgColor
        todayButton.setTitleColor(UIColor.white, for: .normal)
        calenderView.layer.backgroundColor = dateSelectionBG.cgColor
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: date)
        selectedDate = dateFormatter.string(from: date)
    }
    
    @IBAction func ShopDetailsPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main1", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CompanyDetailsViewController") as! CompanyDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func yesterday_clicked(_ sender: Any)
    {
        yesterdayButton.layer.backgroundColor = selectedColor.cgColor
        yesterdayButton.setTitleColor(UIColor.white, for: .normal)
        todayButton.layer.backgroundColor = dateSelectionBG.cgColor
        todayButton.setTitleColor(UIColor.black, for: .normal)
        calenderView.layer.backgroundColor = dateSelectionBG.cgColor
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: yesterday!)
        selectedDate = dateFormatter.string(from: yesterday!)
        userConfigApi()

    }
    
    @IBAction func backButtonPressed(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func calender_clicked(_ sender: Any)
    {
        yesterdayButton.layer.backgroundColor = dateSelectionBG.cgColor
        yesterdayButton.setTitleColor(UIColor.black, for: .normal)
        todayButton.layer.backgroundColor = dateSelectionBG.cgColor
        todayButton.setTitleColor(UIColor.black, for: .normal)
        calenderView.layer.backgroundColor = selectedColor.cgColor
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        popup.isTimePicker = false
        popup.defaultDate = userSelectedDate
        popup.modalPresentationStyle = .overCurrentContext
        popup.delegate = self
        present(popup, animated: true, completion: nil)
    }
    //MARK: Navigation
    func gotoStaffDetails(str:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StaffDetailsViewController") as! StaffDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        vc.selectedDate = selectedDate
        vc.isfrom = str
        //self.navigationController?.pushViewController(vc, animated: true)
        present(vc, animated: true, completion: nil)
    }
    func gotomaintainTimingViewController(Str:String,time:String){
        let storyboard = UIStoryboard(name: "Main1", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MaintainTimingViewController") as! MaintainTimingViewController
        vc.isfrom = Str
        vc.Time = time
        vc.selectedDate = selectedDate
        vc.modalPresentationStyle = .fullScreen
        //self.navigationController?.pushViewController(vc, animated: true)
        present(vc, animated: true, completion: nil)
    }
    func gotoCustomersView(Str:String,time:String){
        let storyboard = UIStoryboard(name: "Main1", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CustomersViewController") as! CustomersViewController
        vc.isfrom = Str
        vc.Time = time
        vc.selectedDate = selectedDate
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    func numericalUI()
    {
          viewSwitch.isOn = false
//        numericalButton.layer.backgroundColor = selectedColor.cgColor
//        numericalButton.setTitleColor(UIColor.white, for: .normal)
//        graphicalButton.layer.backgroundColor = UIColor.white.cgColor
//        graphicalButton.setTitleColor(UIColor.black, for: .normal)
          collectionview.isHidden = false
          graphicalView.isHidden = true
          viewHeight.constant = 860
    }
    func graphicalUI()
    {
          viewSwitch.isOn = true
//        graphicalButton.layer.backgroundColor = selectedColor.cgColor
//        graphicalButton.setTitleColor(UIColor.white, for: .normal)
//        numericalButton.layer.backgroundColor = UIColor.white.cgColor
//        numericalButton.setTitleColor(UIColor.black, for: .normal)
          collectionview.isHidden = true
          graphicalView.isHidden = false
        viewHeight.constant = 1137
        collectionViewGrpahical.isHidden = false
        collectionViewGrpahical.reloadData()
    }
}
extension ShopDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView != collectionViewGrpahical {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "ShopDetailsCollectionViewCell", for: indexPath) as! ShopDetailsCollectionViewCell
            
        cell.sectionLabel.text = category[indexPath.row]
        cell.container.layer.cornerRadius = 10
        cell.container.backgroundColor = bgColors[indexPath.row]

        if (category[indexPath.row] == "OPENED AT")     {
            cell.timeLabel.text = convertto12(time: openedat)
            cell.timeLabel.font = cell.timeLabel.font.withSize(28)
            
        }
        else if (category[indexPath.row] == "FIRST CUSTOMER")   {
            cell.timeLabel.text = convertto12(time: firstcustomer)
        }
        else if (category[indexPath.row] == "CUSTOMERS")    {
            cell.timeLabel.text = "\(customers)"
            cell.timeLabel.font = cell.timeLabel.font.withSize(40)
        }
        else if (category[indexPath.row] == "STAFF")    {
            cell.timeLabel.text = "\(staff)"
            cell.timeLabel.font = cell.timeLabel.font.withSize(40)
        }
        else if (category[indexPath.row] == "CLOSED AT")    {
            cell.timeLabel.text = convertto12(time: closedat)
        }
        else if (category[indexPath.row]  == "KNOWN VISITORS")  {
            cell.timeLabel.text = "\(knownVisitors)"
            cell.timeLabel.font = cell.timeLabel.font.withSize(40)
        }
        
        return cell
        } else {
            if (category[indexPath.row] == "OPENED AT") || (category[indexPath.row] == "FIRST CUSTOMER") || (category[indexPath.row] == "CLOSED AT") {
            let cell = collectionViewGrpahical.dequeueReusableCell(withReuseIdentifier: "TimingCollectionViewCell", for: indexPath) as! TimingCollectionViewCell
            
            if (category[indexPath.row] == "OPENED AT")     {
                cell.clock.hours = Int(converttohour(time: openedat)) ?? 12
                cell.clock.minutes = Int(converttominute(time: openedat)) ?? 12
                cell.timingLabel.text = convertto12(time: openedat)
                cell.descriptionLabel.text = "Opened At"
                cell.viewBAckground.backgroundColor = bgColors[indexPath.row]
                cell.clock.reloadClock()
            }
            else if (category[indexPath.row] == "FIRST CUSTOMER")   {
                cell.clock.hours = Int(converttohour(time: firstcustomer)) ?? 12
                cell.clock.minutes = Int(converttominute(time: firstcustomer)) ?? 12
                cell.descriptionLabel.text = "FIRST CUSTOMER"
                cell.clock.reloadClock()
                cell.viewBAckground.backgroundColor = bgColors[indexPath.row]
                cell.timingLabel.text = convertto12(time: firstcustomer)
            }
            else {
                cell.clock.hours = Int(converttohour(time:closedat)) ?? 12
                cell.clock.minutes = Int(converttominute(time: closedat)) ?? 12
                cell.descriptionLabel.text = "CLOSED AT"
                cell.clock.reloadClock()
                cell.viewBAckground.backgroundColor = bgColors[indexPath.row]
                cell.timingLabel.text = convertto12(time: closedat)
            }
            
            return cell
            } else {
                let cell = collectionViewGrpahical.dequeueReusableCell(withReuseIdentifier: "PersonsCollectionViewCell", for: indexPath) as! PersonsCollectionViewCell
                cell.viewBackGround.backgroundColor = bgColors[indexPath.row]
                
              if (category[indexPath.row] == "CUSTOMERS") {
                cell.donutViewCahrt.goal = Int(customersTarget.text!) ?? 10
                cell.donutViewCahrt.progress = customers
                cell.personsLabel.text = "Customers"
                cell.targetValueLabel.text = customersTarget.text!
                cell.targetLabel.text = "Target"
                cell.visitLabel.text = "\(customers)"
                cell.donutViewCahrt.progressColor = UIColor(red: 0.13, green: 0.37, blue: 0.57, alpha: 1.00)
                cell.donutViewCahrt.reloadInputViews()
              } else if (category[indexPath.row] == "STAFF") {
                cell.donutViewCahrt.goal = Int(staffTarget.text!) ?? 10
                cell.donutViewCahrt.progress = staff
                cell.personsLabel.text = "Staff"
                cell.visitLabel.text = "\(staff)"
                cell.targetValueLabel.text = staffTarget.text!
                cell.targetLabel.text = "Max"
                cell.donutViewCahrt.progressColor = UIColor(red: 0.45, green: 0.34, blue: 0.86, alpha: 1.00)
                cell.donutViewCahrt.reloadInputViews()
              } else {
                cell.donutViewCahrt.goal = Int(visitorsTarget.text!) ?? 10
                cell.donutViewCahrt.progress = knownVisitors
                cell.personsLabel.text = "known\nVisitors"
                cell.targetValueLabel.text = visitorsTarget.text!
                cell.targetLabel.text = "Max"
                cell.donutViewCahrt.progressColor = UIColor(red: 0.42, green: 0.18, blue: 0.21, alpha: 1.00)
                cell.visitLabel.text = "\(knownVisitors)"
                cell.donutViewCahrt.reloadInputViews()
              }
                return cell
                
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = collectionView.frame.width - 10
        var height1 = CGFloat(140)
        if collectionView == collectionViewGrpahical {
         height1 = CGFloat(230)
        }
        return CGSize(width: width, height: height1)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if openedat != "" {
           gotomaintainTimingViewController(Str: "OpenedAt",time: convertto12(time: openedat))
            } else {
                HUD.flash(.label("No data available"), delay: 2.0)
            }
        }
        else if indexPath.row == 1 {
            if firstcustomer != "" {
            gotomaintainTimingViewController(Str: "FirstCustomer",time: convertto12(time: firstcustomer))
            } else {
                HUD.flash(.label("No data available"), delay: 2.0)
            }
        } else if indexPath.row == 4 {
            if closedat != "" {
            gotomaintainTimingViewController(Str: "ClosedAt",time: convertto12(time: closedat))
            } else {
                HUD.flash(.label("No data available"), delay: 2.0)
            }
        } else if indexPath.row == 2 {
            if customers != 0 {
            gotoCustomersView(Str: "customers",time: convertto12(time: "\(customers)"))
            } else {
                HUD.flash(.label("No data available"), delay: 2.0)
            }
        }
        if indexPath.row == 3 {
            if staff != 0 {
            gotoStaffDetails(str: "Staff")
            } else {
                HUD.flash(.label("No data available"), delay: 2.0)
            }
        } else if indexPath.row == 5 {
            if knownVisitors != 0 {
            gotoStaffDetails(str: "Known Visitors")
            } else {
                HUD.flash(.label("No data available"), delay: 2.0)
            }
        }
    }
}
extension ShopDetailsViewController:DatePickerDelegate
{
    func selectedDate(date: String)
    {
        dateLabel.text = date
        selectedDate = date
        userConfigApi()

    }
    
    func cancelDateSelection()
    {
        
    }
    
    
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
extension UIView {


    func rotate(degrees: CGFloat) {

        let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
            return degrees / 180.0 * CGFloat.pi
        }
        self.transform =  CGAffineTransform(rotationAngle: degreesToRadians(degrees))

        // If you like to use layer you can uncomment the following line
        //layer.transform = CATransform3DMakeRotation(degreesToRadians(degrees), 0.0, 0.0, 1.0)
    }
}
