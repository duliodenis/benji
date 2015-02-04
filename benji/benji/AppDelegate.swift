//
//  AppDelegate.swift
//  benji
//
//  Created by Dulio Denis on 2/4/15.
//  Copyright (c) 2015 ddApps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.setApplicationId("z3Dm8uDittcBOO56J5uDLbeNlHhqmh0ESr0U3Mzn", clientKey: "Yigtm1DQbwZ2UYx8526sTzNybqnbDWxRPKLSVtNB")
        
        var defaultACL = PFACL()
        defaultACL.setPublicReadAccess(false)
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
        
        return true
    }

}

