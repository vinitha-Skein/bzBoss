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
    
    let arrayxString = ["12/07", "13/07", "14/07", "15/07", "16/07","17/07","18/07"]
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


    override func viewDidLoad() {
        super.viewDidLoad()
        collchaectioview.delegate = self
        collchaectioview.dataSource = self
        // Do any additional setup after loading the view.
       apiCall()
        print(time1)
    }
    @IBAction func back_pressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
            {                print("Copunt",self.viewModel.individualstaffdetails?.staffDetailsData?.count)

                self.activityIndicator(self.view, startAnimate: false)
                self.storeDatatoArray()
                
                //time1.append(converttoTime(time: date1))
                print(self.time1)
                print(self.time2)
                print(self.time3)
                print(self.time4)
                print(self.time5)
                print(self.time6)
                print(self.time7)

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
   func storeDatatoArray()
   {
    staffCount = viewModel.individualstaffdetails?.staffDetailsData?.count ?? 0
    collchaectioview.reloadData()
    let n = (viewModel.individualstaffdetails?.staffDetailsData!.count)!
    let count = 0..<n
    for number in count
    
    {
        time1.append("staff \(number)")
        let m = viewModel.individualstaffdetails?.staffDetailsData![number].staffdata?.count ?? 2
        print("Value of m",m)
        let innercount = 0..<m
        for innernumber in innercount
        {
            
            var date1 =  viewModel.individualstaffdetails?.staffDetailsData![number].staffdata?[innernumber].first_appearance_date_time ?? "2021-07-10 11:45:22"
            
            time1[number].append(converttoTime(time: date1))
            //print(number)
          
//            var date2 =
//
//            viewModel.individualstaffdetails?.staffDetailsData?[number].staffdata?[innernumber].first_appearance_date_time ?? "2021-07-10 11:45:22"
//            time2.append(converttoTime(time: date2))
//
//            var date3 =  viewModel.individualstaffdetails?.staffDetailsData?[number].staffdata?[innernumber].first_appearance_date_time ?? "2021-07-10 11:45:22"
//            time3.append(converttoTime(time: date3))
//
//            var date4 =  viewModel.individualstaffdetails?.staffDetailsData?[number].staffdata?[innernumber].first_appearance_date_time ?? "2021-07-10 11:45:22"
//            time4.append(converttoTime(time: date4))
//            var date5 =  viewModel.individualstaffdetails?.staffDetailsData?[number].staffdata?[innernumber].first_appearance_date_time ?? "2021-07-10 11:45:22"
//            time5.append(converttoTime(time: date5))
//
//            var date6 =  viewModel.individualstaffdetails?.staffDetailsData?[number].staffdata?[innernumber].first_appearance_date_time ?? "2021-07-10 11:45:22"
//            time6.append(converttoTime(time: date6))
//
//            var date7 =  viewModel.individualstaffdetails?.staffDetailsData?[number].staffdata?[innernumber].first_appearance_date_time ?? "2021-07-10 11:45:22"
//            time7.append(converttoTime(time: date7))
        }
    
    }
    print(time1[0])
   }
    func converttoTime(time: String) ->  String
    {   let tempDate = time
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-d HH:mm:ss"
        var date1 = dateFormatter.date(from:tempDate)!
        
        
        var dateFormatter1 = DateFormatter()
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
        return staffCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCollectionViewCell", for: indexPath) as! testCollectionViewCell
        cell.valuefor1(str: value1[indexPath.row])
        cell.valuefor2(str: value2[indexPath.row])
        cell.valuefor3(str: value3[indexPath.row])
        cell.valuefor4(str: value4[indexPath.row])
        cell.valuefor5(str: value5[indexPath.row])
        cell.valuefor6(str: value6[indexPath.row])
        cell.valuefor7(str: value7[indexPath.row])
        cell.staffLabel.text = viewModel.individualstaffdetails?.staffDetailsData?[indexPath.row].first_name ?? "Staff 1"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collchaectioview.frame.width, height: collchaectioview.frame.height)
    }
}
