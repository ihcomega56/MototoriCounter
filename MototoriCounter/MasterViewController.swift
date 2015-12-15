//
//  MasterViewController.swift
//  MototoriCounter
//
//  Created by ihcomega on 2015/12/08.
//  Copyright © 2015年 ihcomega. All rights reserved.
//

import UIKit

var monthlyFee = 0
var eachTimeFee = 0

class MasterViewController: UITableViewController {

    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    
    var detailViewController: DetailViewController? = nil
    var dates = [AnyObject]()
    
    @IBOutlet weak var feeButon: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        let currentDate = NSDate()
        if (dates.count > 0 && calendar.isDate(currentDate, equalToDate: dates[0] as! NSDate, toUnitGranularity: .Month)) {
            let alertController = UIAlertController(title: "かぶった！", message: "追加しなくておｋ(´▽`) '`,、'`,、", preferredStyle: .Alert)
            let action = UIAlertAction(title: "はーい", style: .Default, handler: nil)
            alertController.addAction(action)
            presentViewController(alertController, animated: true, completion: nil)
        } else {
            dates.insert(currentDate, atIndex: 0)
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let date = dates[indexPath.row] as! NSDate
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.dateForDetail = date
                controller.fees = (monthlyFee, eachTimeFee)
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let date = NSDate()
        let year = calendar.component(.Year, fromDate: date)
        let month = calendar.component(.Month, fromDate: date)
        cell.textLabel!.text = String(year) + "年" + String(month) + "月( ᐛ👐)"
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // MARK: - Tool Bar
    
    @IBAction func addMonthlyFee(sender: AnyObject) {
        var monthlyFeeField: UITextField!
        var eachTimeFeeField: UITextField!
        
        let alertController: UIAlertController = UIAlertController(title: "費用を更新=͟͟͞͞⊂(’ω’)=͟͟͞͞⊃", message: "月額と都度会費いれてね！", preferredStyle: .Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .Cancel) { action -> Void in
        }
        alertController.addAction(cancelAction)
        
        let logintAction: UIAlertAction = UIAlertAction(title: "登録", style: .Default) { action -> Void in
            if (!monthlyFeeField.text!.isEmpty) {
                monthlyFee = Int(monthlyFeeField.text!)!
            }
            if (!eachTimeFeeField.text!.isEmpty) {
                eachTimeFee = Int(eachTimeFeeField.text!)!
            }
        }
        alertController.addAction(logintAction)
        
        alertController.addTextFieldWithConfigurationHandler { textField -> Void in
            textField.keyboardType = UIKeyboardType.NumberPad
            monthlyFeeField = textField
            textField.placeholder = "月額〜"
            textField.text = String(monthlyFee)
        }
        alertController.addTextFieldWithConfigurationHandler { textField -> Void in
            textField.keyboardType = UIKeyboardType.NumberPad
            eachTimeFeeField = textField
            textField.placeholder = "都度会費〜"
            textField.text = String(eachTimeFee)
        }
        
        presentViewController(alertController, animated: true, completion: nil)

    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            dates.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

