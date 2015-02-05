//
//  AccountViewController.swift
//  benji
//
//  Created by Dulio Denis on 2/5/15.
//  Copyright (c) 2015 ddApps. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var reasonText: UITextField!
    @IBOutlet weak var transactionAmount: UITextField!
    
    var transaction = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var user = PFUser.currentUser()
        var query = PFQuery(className: "transactions")
        query.whereKey("accountholder", equalTo: user)
        
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error:NSError!) -> Void in
            if error == nil {
                if let accountObjects = objects as? [PFObject] {
                    for serverTransaction in accountObjects {
                        self.transaction += serverTransaction["transaction"] as Double
                    }
                }
                
                let balance = String(format: "Balance: $%.2f", self.transaction)
                self.balanceLabel.text = balance
            }
        }
    }

    @IBAction func makeTransaction(sender: AnyObject) {
        var deposit = (transactionAmount.text as NSString).doubleValue
        var reason = reasonText.text
        
        var transaction = PFObject(className: "transactions")
        
        transaction["transaction"] = deposit
        transaction["reason"] = reason
        transaction["accountholder"] = PFUser.currentUser()
        transaction.saveInBackgroundWithBlock { (success:Bool!, error: NSError!) -> Void in
            if success != nil {
                println("Success")
                
                let currentBalance = (self.balanceLabel.text! as NSString).doubleValue
                let total = currentBalance + deposit
                
                self.balanceLabel.text = String(format: "Balance: $%.2f", total)
                self.transactionAmount.text = ""
                self.reasonText.text = ""
                
            } else {
                println("Error: \(error)")
            }
        }
        
        
    }

}
