//
//  ShopDetailsViewController.swift
//  bzBoss
//
//  Created by Skeintech on 01/07/21.
//

import UIKit

class ShopDetailsViewController: UIViewController
{
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
    }
    
    @IBAction func numerical_Clicked(_ sender: Any)
    {
        numericalButton.layer.backgroundColor = selectedColor.cgColor
        numericalButton.setTitleColor(UIColor.white, for: .normal)
        graphicalButton.layer.backgroundColor = UIColor.white.cgColor
        graphicalButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func graphical_Clicked(_ sender: Any)
    {
        graphicalButton.layer.backgroundColor = selectedColor.cgColor
        graphicalButton.setTitleColor(UIColor.white, for: .normal)
        numericalButton.layer.backgroundColor = UIColor.white.cgColor
        numericalButton.setTitleColor(UIColor.black, for: .normal)
    }
    @IBAction func today_Clicked(_ sender: Any)
    {
        yesterdayButton.layer.backgroundColor = dateSelectionBG.cgColor
        yesterdayButton.setTitleColor(UIColor.black, for: .normal)
        todayButton.layer.backgroundColor = selectedColor.cgColor
        todayButton.setTitleColor(UIColor.white, for: .normal)
        calenderView.layer.backgroundColor = dateSelectionBG.cgColor
    }
    
    @IBAction func yesterday_clicked(_ sender: Any)
    {
        yesterdayButton.layer.backgroundColor = selectedColor.cgColor
        yesterdayButton.setTitleColor(UIColor.white, for: .normal)
        todayButton.layer.backgroundColor = dateSelectionBG.cgColor
        todayButton.setTitleColor(UIColor.black, for: .normal)
        calenderView.layer.backgroundColor = dateSelectionBG.cgColor
    }
    @IBAction func calender_clicked(_ sender: Any)
    {
        yesterdayButton.layer.backgroundColor = dateSelectionBG.cgColor
        yesterdayButton.setTitleColor(UIColor.black, for: .normal)
        todayButton.layer.backgroundColor = dateSelectionBG.cgColor
        todayButton.setTitleColor(UIColor.black, for: .normal)
        calenderView.layer.backgroundColor = selectedColor.cgColor
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
}
