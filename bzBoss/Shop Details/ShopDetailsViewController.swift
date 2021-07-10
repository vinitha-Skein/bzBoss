//
//  ShopDetailsViewController.swift
//  bzBoss
//
//  Created by Skeintech on 01/07/21.
//

import UIKit
import BEMAnalogClock


class ShopDetailsViewController: UIViewController
{
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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var knownVistorsChart: DonutView!
    @IBOutlet weak var staffsChart: DonutView!
    @IBOutlet weak var customersChart: DonutView!
    @IBOutlet weak var closedatClock: BEMAnalogClockView!
    @IBOutlet weak var firstCustomerClock: BEMAnalogClockView!
    @IBOutlet weak var openedatClock: BEMAnalogClockView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var graphicalButton: Mybutton!
    @IBOutlet var numericalButton: Mybutton!
    @IBOutlet var calenderView: UIView!
    @IBOutlet var yesterdayButton: Mybutton!
    @IBOutlet var collectionview: UICollectionView!
    @IBOutlet var todayButton: Mybutton!
    let viewModel = ShopdetailsViewModel()
    
    var dateSelectionBG = UIColor(red: 195/255, green: 250/255, blue: 255/255, alpha: 1)
    var selectedColor = UIColor(red: 29/255, green: 138/255, blue: 254/255, alpha: 1)
    
    var openedat = String()
    var closedat = String()
    var firstcustomer = String()
    var customers = Int()
    var staff = Int()
    var knownVisitors = Int()
    var toggle = String()
    var premiseImagevalue = String()
    
    var category = ["OPENED AT","FIRST CUSTOMER","CUSTOMERS","STAFF","CLOSED AT","KNOWN VISITORS"]
//    var green1 = UIColor(red: 76/255, green: 192/255, blue: 166/255, alpha: 1)
//    var orange = UIColor(red: 243/255, green: 118/255, blue: 108/255, alpha: 1)
//    var blue = UIColor(red: 119/255, green: 177/255, blue: 223/255, alpha: 1)
//    var violet = UIColor(red: 166/255, green: 148/255, blue: 232/255, alpha: 1)

    var bgColors = [UIColor(red: 76/255, green: 192/255, blue: 166/255, alpha: 1),UIColor(red: 243/255, green: 118/255, blue: 108/255, alpha: 1),UIColor(red: 119/255, green: 177/255, blue: 223/255, alpha: 1),UIColor(red: 166/255, green: 148/255, blue: 232/255, alpha: 1),UIColor(red: 76/255, green: 192/255, blue: 166/255, alpha: 1),UIColor(red: 243/255, green: 118/255, blue: 108/255, alpha: 1)]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionview.delegate = self
        collectionview.dataSource = self
        apiCall()
        setUpUI()
    }
    
    func apiCall()
    {
        activityIndicator(view, startAnimate: true)
            UserDefaults.standard.set("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImRhZjA2NDViNWY1N2NkNTRmM2QwNzczZWEwMjk4NzU1NjMxMGUxM2VjNGZhMjY2ZDcyOWE4N2MyNTZlMTVlYmQ2ZGI3OGQ1NmFlYWI5ZmZkIn0.eyJhdWQiOiIxIiwianRpIjoiZGFmMDY0NWI1ZjU3Y2Q1NGYzZDA3NzNlYTAyOTg3NTU2MzEwZTEzZWM0ZmEyNjZkNzI5YTg3YzI1NmUxNWViZDZkYjc4ZDU2YWVhYjlmZmQiLCJpYXQiOjE2MjU1NzE3NDcsIm5iZiI6MTYyNTU3MTc0NywiZXhwIjoxNjU3MTA3NzQ3LCJzdWIiOiIxMyIsInNjb3BlcyI6W119.F6REeZaPqt-SkRfciIkQeHPzntgYyLTETHKN0mAH9k8AujZWhnWTf2PtX-5ICBI2drVVLoYxsfCgpq2Y9w73m1ZTdCmDfksIyYuk2jJKJnx1PiZoV6r-NqDG0h20w9icjx1t51V9puoohZlnrByufjcdHv3rGpsSN2MwFqrN2ni1ujEFNX27eB67p6ajPRFhJTCV4-5gHI7zDhZNREpFZxb3tCe1Bnr2tDaRBsxsHTmnAe5FasDXy_XGWk5h5t8tlPm8BRNZ9x6GoiiNtYtxEIIUDXpZrjEL1Jdlxokg7BwP7nt1kTNcv8abLQ5qL3XOt0Mh1mwxMsJpOhiuujcNjuvXtGETvXnAPtmVxx6g6vQW1uBNCM8WXpkp0_Rdc5OoGvrRMSWhoc7i3s7RuigsadaavhCOWhioBujMmFJOlPUwHidLVGFNnkfD5T4FPOYmoIwHILeLYbhs9jESZDnhDgxHx8_Mb0Qjh4ysKKqmfl1Rduu5XrgbLKS_ys_oIwxVDthd3GqrAcEcYd8R3ujQJx2fI6lPUFRqxkjxdUkBDlwFn0qEbsQXDNQqikWweAsesa46iDsIehy_AdfBRc6VNjAGFjtZdD7L04P6baZrijdyjGK4rcRaGAagdDWxkwyO32NwNC3yS6fDj7FTeGiXORFMJQHBKwjb9sQt-8J8sEU", forKey: "Authorization")

        let params = [
          "date": "WTR0RVJUUWUrMFFFWVBkdGEzOHZjQT09",
            "id":"YVg2b0xYZTQvYzhKU3NEWjdyOGZzQT09",
            "user_id":"YTNYYWg2c3FHR2VhYUJGenhmMk8zdz09"]
        viewModel.shopDetail(params: params)
        viewModel.shopdetailsfetchedSuccess =
            {
                self.activityIndicator(self.view, startAnimate: false)
                self.setDatatoVariables()
                self.filldata()
                self.collectionview.reloadData()
            //UserDefaults.standard.set(true, forKey: "isLoggedIn"
        }
    }
    
    func setDatatoVariables()
    {
        self.openedat = self.viewModel.shopdetailsData?.opened_at ?? "-"
        self.closedat = self.viewModel.shopdetailsData?.closed_at ?? "-"
        self.customers = self.viewModel.shopdetailsData?.number_of_customers_max ?? 0
        self.knownVisitors = self.viewModel.shopdetailsData?.number_of_known_visitors_max ?? 0
        self.firstcustomer = self.viewModel.shopdetailsData?.first_customer_time ?? "-"
        self.staff = self.viewModel.shopdetailsData?.number_of_staff_max ?? 0
        self.toggle = self.viewModel.shopdetailsData?.userconfigdata?.toggle ?? "graphic"
        self.premiseImagevalue = self.viewModel.shopdetailsData?.premisedata?.photo ?? ""
    }
    func filldata()
    {
        premiseTitle.text = viewModel.shopdetailsData?.premisedata?.name
        premiseCityLabel.text = viewModel.shopdetailsData?.premisedata?.city
        premiseStateLabel.text = viewModel.shopdetailsData?.premisedata?.state
        dateandTimeLabel.text = viewModel.shopdetailsData?.getcurrentstatus?.last_updated
        statusLabel.text = viewModel.shopdetailsData?.getcurrentstatus?.status
        
        if (toggle == "graphic")
        {
            graphicalUI()
        }
        else
        {
            numericalUI()
        }
            setImage(from: premiseImagevalue)
    }
    func setUpUI()
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: date)
        scrollView.isHidden = true
        firstCustomerView.layer.borderColor = UIColor.black.cgColor
        firstCustomerView.layer.borderWidth = 0.5
        firstCustomerView.layer.cornerRadius = 5
        customersChartView.layer.borderColor = UIColor.black.cgColor
        customersChartView.layer.borderWidth = 0.5
        customersChartView.layer.cornerRadius = 5
        staffChartView.layer.borderColor = UIColor.black.cgColor
        staffChartView.layer.borderWidth = 0.5
        staffChartView.layer.cornerRadius = 5
        closedatView.layer.borderColor = UIColor.black.cgColor
        closedatView.layer.borderWidth = 0.5
        closedatView.layer.cornerRadius = 5
        visitorsChartView.layer.borderColor = UIColor.black.cgColor
        visitorsChartView.layer.borderWidth = 0.5
        visitorsChartView.layer.cornerRadius = 5
        openedatView.layer.borderColor = UIColor.black.cgColor
        openedatView.layer.borderWidth = 0.5
        openedatView.layer.cornerRadius = 5
    }
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.premiseImage.image = image
            }
        }
    }
    @IBAction func numerical_Clicked(_ sender: Any)
    {
        numericalUI()
    }
    
    
    @IBAction func graphical_Clicked(_ sender: Any)
    {
        graphicalUI()
    }
    @IBAction func refresh_clicked(_ sender: Any)
    {
        apiCall()
    }
    @IBAction func today_Clicked(_ sender: Any)
    {
        yesterdayButton.layer.backgroundColor = dateSelectionBG.cgColor
        yesterdayButton.setTitleColor(UIColor.black, for: .normal)
        todayButton.layer.backgroundColor = selectedColor.cgColor
        todayButton.setTitleColor(UIColor.white, for: .normal)
        calenderView.layer.backgroundColor = dateSelectionBG.cgColor
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: date)
    }
    
    @IBAction func ShopDetailsPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main1", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CompanyDetailsViewController") as! CompanyDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
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

    }
    
    @IBAction func backButtonPressed(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
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
        popup.modalPresentationStyle = .overCurrentContext
        popup.delegate = self
        present(popup, animated: true, completion: nil)
    }
    //MARK: Navigation
    func gotoStaffDetails() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StaffDetailsViewController") as! StaffDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func gotomaintainTimingViewController(Str:String){
        let storyboard = UIStoryboard(name: "Main1", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MaintainTimingViewController") as! MaintainTimingViewController
        vc.isfrom = Str
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func numericalUI()
    {
        numericalButton.layer.backgroundColor = selectedColor.cgColor
        numericalButton.setTitleColor(UIColor.white, for: .normal)
        graphicalButton.layer.backgroundColor = UIColor.white.cgColor
        graphicalButton.setTitleColor(UIColor.black, for: .normal)
        collectionview.isHidden = false
        scrollView.isHidden = true
    }
    func graphicalUI()
    {
        graphicalButton.layer.backgroundColor = selectedColor.cgColor
        graphicalButton.setTitleColor(UIColor.white, for: .normal)
        numericalButton.layer.backgroundColor = UIColor.white.cgColor
        numericalButton.setTitleColor(UIColor.black, for: .normal)
        collectionview.isHidden = true
        scrollView.isHidden = false

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopDetailsCollectionViewCell", for: indexPath) as! ShopDetailsCollectionViewCell
        cell.sectionLabel.text = category[indexPath.row]
        cell.container.layer.cornerRadius = 10
        cell.container.backgroundColor = bgColors[indexPath.row]
        if (indexPath.row == 0)
        {
            cell.timeLabel.text = openedat
        }
        else if (indexPath.row == 1)
        {
            cell.timeLabel.text = firstcustomer
        }
        else if (indexPath.row == 2)
        {
//            if (customers == 0)
//            {
//                cell.timeLabel.text = "-"
//
//            }
            cell.timeLabel.text = "\(customers)"
        }
        else if (indexPath.row == 3)
        {
            cell.timeLabel.text = "\(staff)"
        }
        else if (indexPath.row == 4)
        {
            cell.timeLabel.text = closedat
        }
        else if (indexPath.row == 5)
        {
            cell.timeLabel.text = "\(knownVisitors)"
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var width = collectionView.frame.width/2 - 10
        return CGSize(width: width, height: 140)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
           gotomaintainTimingViewController(Str: "OpenedAt")
        }
        else if indexPath.row == 1 {
            gotomaintainTimingViewController(Str: "FirstCustomer")
        } else if indexPath.row == 4 {
            gotomaintainTimingViewController(Str: "ClosedAt")
        }
        if indexPath.row == 3{
           gotoStaffDetails()
        }
    }
}
extension ShopDetailsViewController:DatePickerDelegate
{
    func selectedDate(date: String)
    {
        dateLabel.text = date
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
