//
//  PDFViewController.swift
//  bzBoss
//
//  Created by Vinitha on 12/08/21.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    
    @IBOutlet weak var topView: UIView!
    
    var pdfURL: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }    
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
      dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
