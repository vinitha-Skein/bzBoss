//
//  OnboardingViewController.swift
//  bzBoss
//
//  Created by Vinitha on 30/06/21.
//

import UIKit

class OnboardingViewController: UIViewController,UIScrollViewDelegate{

    var menuimages = ["ic_slider_one","ic_slider_two","ic_slider_three","ic_slider_four"]
    var menuTitles = ["TRACK NUMBER OF CUSTOMER VISITS","MANAGE STAFF ATTENDENCES","TRACK BUSSINESS OPEN AND CLOSE TIME","KNOW THE DEMOGRAPHY OF YOUR CUSTOMER"]
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var begin = false
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
    }
    override func viewWillAppear(_ animated: Bool)
    {
//        companytableview.tableFooterView = MyUIView()
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    @objc func scrollToNextCell(){
        
        if let coll  = collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < menuimages.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // If the scroll animation ended, update the page control to reflect the current page we are on
        
        pageControl.currentPage = Int((collectionView.contentOffset.x / collectionView.contentSize.width) * CGFloat(menuimages.count))
        
        if collectionView.contentSize.width == collectionView.contentOffset.x + self.view.frame.width
        {
            begin = true
            
        }
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        // Called when manually setting contentOffset
        scrollViewDidEndDecelerating(scrollView)
        
    }
    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func startTimer() {
        
//        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector(("scrollToNextCell")), userInfo: nil, repeats: true);
        let _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNextCell), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func getstartedButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func signinButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = menuimages.count
        return menuimages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        cell.menuImage.image = UIImage(named: menuimages[indexPath.row])
        cell.menuTitle.text = menuTitles[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
            let width = collectionView.frame.width
            return CGSize(width: width, height: collectionView.frame.height)
    }
}
