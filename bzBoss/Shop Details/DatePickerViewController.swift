//
//  DatePickerViewController.swift
//  DatePicker
//
//  Created by SkeinTechnologies on 23/10/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    var delegate:DatePickerDelegate?
    @IBOutlet weak var datePicker: UIDatePicker!
    var isTimePicker = false
    var defaultDate = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        // Do any additional setup after loading the view.
        
        if isTimePicker{
            datePicker.datePickerMode = .time
        }else{
            datePicker.datePickerMode = .date
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd"

        let date = dateFormatter.date(from: defaultDate)
        let date1 = dateFormatter.date(from: "2021-06-08")

        datePicker.date = date ?? date1!
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.cancelDateSelection()
    }
    @IBAction func doneAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
        let dateString = dateFormatter.string(from: datePicker.date)
        print(dateString)
        delegate?.selectedDate(date: dateString)
    }
    @IBAction func dateChanged(_ sender: Any) {
    }
}



protocol DatePickerDelegate {
    func selectedDate(date:String)
    func cancelDateSelection()
}
