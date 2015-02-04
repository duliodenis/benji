//
//  ViewController.swift
//  benji
//
//  Created by Dulio Denis on 2/4/15.
//  Copyright (c) 2015 ddApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

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
            
        }
    }


}

