//
//  DetailViewController.swift
//  MototoriCounter
//
//  Created by Ayana Yokota on 2015/12/08.
//  Copyright © 2015年 ihcomega. All rights reserved.
//

import UIKit


var numbersOfTimes: Dictionary? = Dictionary<String, Int>()
var times = 0


class DetailViewController: UIViewController {
    
    var year = ""
    var month = ""

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                year = String(calendar.component(.Year, fromDate: detail as! NSDate))
                month = String(calendar.component(.Month, fromDate: detail as! NSDate))
                label.text = year + "年" + month + "月"
            }
        }
    }
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var timesLabel: UILabel!

    @IBAction func minus(sender: UIButton) {
        times -= 1
        timesLabel.text = String(times)
        numbersOfTimes![year+month] = times
    }
    @IBAction func plus(sender: UIButton) {
        times += 1
        timesLabel.text = String(times)
    }
    
    func calcurate() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        timesLabel.text = String(times)
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

