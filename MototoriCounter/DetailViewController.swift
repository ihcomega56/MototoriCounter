//
//  DetailViewController.swift
//  MototoriCounter
//
//  Created by Ayana Yokota on 2015/12/08.
//  Copyright © 2015年 ihcomega. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    var times = 0

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
                let year = calendar.component(.Year, fromDate: detail as! NSDate)
                let month = calendar.component(.Month, fromDate: detail as! NSDate)
                label.text = String(year) + "年" + String(month) + "月"
            }
        }
    }
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var timesLabel: UILabel!

    @IBAction func minus(sender: UIButton) {
        times -= 1
        timesLabel.text = String(times)
    }
    @IBAction func plus(sender: UIButton) {
        times += 1
        timesLabel.text = String(times)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

