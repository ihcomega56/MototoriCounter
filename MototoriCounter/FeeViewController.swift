//
//  FeeViewController.swift
//  MototoriCounter
//
//  Created by ihcomega on 2015/12/16.
//  Copyright © 2015年 ihcomega. All rights reserved.
//

import UIKit

var monthlyFee = 0
var eachTimeFee = 0

class FeeViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var monthlyFeeField: UITextField!
    @IBOutlet weak var eachTimeFeeField: UITextField!
    
    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "費用を更新=͟͟͞͞⊂(’ω’)=͟͟͞͞⊃"
        messageLabel.text = "月額と都度会費いれてね！"
        monthlyFeeField.placeholder = "月額〜"
        monthlyFeeField.text = String(monthlyFee)
        eachTimeFeeField.placeholder = "都度会費〜"
        eachTimeFeeField.text = String(eachTimeFee)
    }
    
    @IBAction func addFees(sender: AnyObject) {
        if let monthlyFeeText = monthlyFeeField.text {
            if let month = Int(convertToHalf(monthlyFeeText)) {
                monthlyFee = month
            }
        }
        if let eachTimeFeeText = eachTimeFeeField.text {
            if let each = Int(convertToHalf(eachTimeFeeText)) {
                eachTimeFee = each
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func convertToHalf(text: String) -> String {
        let convertedText = NSMutableString(string: text) as CFMutableString
        CFStringTransform(convertedText, nil, kCFStringTransformFullwidthHalfwidth, false)
        return convertedText as String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


