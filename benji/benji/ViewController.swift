//
//  ViewController.swift
//  benji
//
//  Created by Dulio Denis on 2/4/15.
//  Copyright (c) 2015 ddApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Savings"
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if PFUser.currentUser() == nil {
            let login = PFLogInViewController()
            let signup = PFSignUpViewController()
            
            login.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.SignUpButton | PFLogInFields.LogInButton |
            PFLogInFields.PasswordForgotten
            
            login.delegate = self
            signup.delegate = self
            
            login.signUpController = signup
            self.presentViewController(login, animated: true, completion: nil)
            
        } else {
            var username = PFUser.currentUser().username
            welcomeLabel.text = username
        }
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
        var account = PFObject(className: "transactions")
        account["accountholder"] = PFUser.currentUser()
        user.saveInBackgroundWithBlock{(success:Bool!, error:NSError!) -> Void in
            if success != nil {
                NSLog("Success")
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                NSLog("%@", error)
            }
        }
    }
    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

