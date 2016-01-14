//
//  MasterViewController.swift
//  MototoriCounter
//
//  Created by ihcomega on 2015/12/08.
//  Copyright © 2015年 ihcomega. All rights reserved.
//

import UIKit
import RealmSwift

class MasterViewController: UITableViewController {

    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    let realm = try! Realm()
    
    var detailViewController: DetailViewController? = nil
    var dates = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        // runs after application launched
        let launchNotifier = NSNotificationCenter.defaultCenter()
        launchNotifier.addObserver(
            self,
            selector: "readAllData:",
            name:UIApplicationWillTerminateNotification,
            object: nil)
        
        // runs before application closing
        // TODO これちゃんと呼ばれるか実機で確認しよう(╭☞•́⍛•̀)╭☞
        let terminationNotifier = NSNotificationCenter.defaultCenter()
        terminationNotifier.addObserver(
            self,
            selector: "writeAllData:",
            name:UIApplicationWillTerminateNotification,
            object: nil)
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
        
        var currentYearField: UITextField!
        var currentMonthField: UITextField!
        
        let inputAlert: UIAlertController = UIAlertController(title: "追加する年月は(•̃͡ε•̃͡)∫?", message: "今月の分なら、そのままで！", preferredStyle: .Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .Cancel) { action -> Void in
        }
        inputAlert.addAction(cancelAction)
        
        let logintAction: UIAlertAction = UIAlertAction(title: "追加", style: .Default) { action -> Void in
            if let currentYear = currentYearField.text, currentMonth = currentMonthField.text {
                self.insert(String(currentYear), month: String(currentMonth))
            }
        }
        inputAlert.addAction(logintAction)
        
        inputAlert.addTextFieldWithConfigurationHandler { textField -> Void in
            textField.keyboardType = UIKeyboardType.NumberPad
            currentYearField = textField
            textField.placeholder = "年"
            textField.text = String(self.calendar.component(.Year, fromDate: currentDate))
        }
        inputAlert.addTextFieldWithConfigurationHandler { textField -> Void in
            textField.keyboardType = UIKeyboardType.NumberPad
            currentMonthField = textField
            textField.placeholder = "月"
            textField.text = String(self.calendar.component(.Month, fromDate: currentDate))
        }
        
        presentViewController(inputAlert, animated: true, completion: nil)
    }
    
    func insert(year: String, month: String) {
        let inputDate = year + "年" + month + "月"
        if (dates.count > 0 && dates.contains(inputDate)) {
            let duplicateAlert = UIAlertController(title: "かぶった！", message: "追加しなくておｋ(´▽`) '`,、'`,、", preferredStyle: .Alert)
            let action = UIAlertAction(title: "はーい", style: .Default, handler: nil)
            duplicateAlert.addAction(action)
            presentViewController(duplicateAlert, animated: true, completion: nil)
        } else if (Int(year) == nil || Int(month) == nil) {
            let validationAlert = UIAlertController(title: "数字ちゃう！", message: "年月いれてくれよ(´▽`) '`,、'`,、", preferredStyle: .Alert)
            let action = UIAlertAction(title: "はーい", style: .Default, handler: nil)
            validationAlert.addAction(action)
            presentViewController(validationAlert, animated: true, completion: nil)
        } else {
            dates.insert(inputDate, atIndex: 0)
            let record =  RealmSwift()
            record.date = inputDate
            try! realm.write {
                realm.add(record, update: true)
            }
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let date = dates[indexPath.row]
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

        cell.textLabel!.text = dates[indexPath.row] + "( ᐛ👐)"
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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

