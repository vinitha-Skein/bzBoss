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
    var dateSelectionBG = UIColor(red: 195/255, green: 250/255, blue: 255/255, alpha: 1)
    var selectedColor = UIColor(red: 29/255, green: 138/255, blue: 254/255, alpha: 1)
    
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
        
        setUpUI()
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
    @IBAction func numerical_Clicked(_ sender: Any)
    {
        numericalButton.layer.backgroundColor = selectedColor.cgColor
        numericalButton.setTitleColor(UIColor.white, for: .normal)
        graphicalButton.layer.backgroundColor = UIColor.white.cgColor
        graphicalButton.setTitleColor(UIColor.black, for: .normal)
        collectionview.isHidden = false
        scrollView.isHidden = true
    }
    
    @IBAction func graphical_Clicked(_ sender: Any)
    {
        graphicalButton.layer.backgroundColor = selectedColor.cgColor
        graphicalButton.setTitleColor(UIColor.white, for: .normal)
        numericalButton.layer.backgroundColor = UIColor.white.cgColor
        numericalButton.setTitleColor(UIColor.black, for: .normal)
        collectionview.isHidden = true
        scrollView.isHidden = false
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
    
    @IBAction func backButtonPressed(_ sender: Any) {
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
