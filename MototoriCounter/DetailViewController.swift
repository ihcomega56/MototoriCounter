//
//  DetailViewController.swift
//  MototoriCounter
//
//  Created by ihcomega on 2015/12/08.
//  Copyright © 2015年 ihcomega. All rights reserved.
//

import UIKit


var numbersOfTimes: Dictionary? = Dictionary<String, Int>()
var times = 0

class DetailViewController: UIViewController {
    
    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    
    var year = ""
    var month = ""

    @IBOutlet weak var detailPage: UINavigationItem!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var timesLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var monthlyFeeLabel: UILabel!
    @IBOutlet weak var eachTimeFeeLabel: UILabel!
    @IBOutlet weak var feeButton: UIBarButtonItem!

    var dateForDetail: NSDate? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    var fees: (Int, Int)? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        if let date = self.dateForDetail {
                year = String(calendar.component(.Year, fromDate: date))
                month = String(calendar.component(.Month, fromDate: date))
                detailPage.title = year + "年" + month + "月"
        }
    }
    
    @IBAction func minus(sender: UIButton) {
        if (times > 0) {
            times -= 1
        }
            updateTimes(times)
        resultLabel.text = calcurate(self.fees!)
    }
    
    @IBAction func plus(sender: UIButton) {
        times += 1
        updateTimes(times)
        resultLabel.text = calcurate(self.fees!)
    }
    
    func updateTimes(times: Int) {
        timesLabel.text = String(times)
        numbersOfTimes![year+month] = times
    }
    
    func calcurate(fees: (Int, Int)) -> String {
        if (fees.1 == 0) {
            return "会費情報くれさい( '_' )"
        }
        let cost = fees.1 * times
        if (cost < fees.0) {
            var left = (fees.0 - cost) / fees.1
            if ((fees.0 - cost) % fees.1 != 0) {
                left += 1
            }
            return "あと" + String(left) + "回(ી(΄◞ิ౪◟ิ‵)ʃ)"
        } else {
            return "元とった(ી(΄◞ิ౪◟ิ‵)ʃ)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        monthlyFeeLabel.text = "月額" + String(monthlyFee) + "えん"
        eachTimeFeeLabel.text = "都度" + String(eachTimeFee) + "えん"
        timesLabel.text = String(times)
        resultLabel.text = calcurate(fees!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

