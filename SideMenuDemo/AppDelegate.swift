//
//  AppDelegate.swift
//  SideMenuDemo
//
//  Created by Eric Hodgins on 2016-11-26.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let centerNav = storyBoard.instantiateViewController(withIdentifier: "CenterNav") as! UINavigationController
        let menuVC = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuViewController
        menuVC.centerViewController = centerNav.viewControllers.first as? CenterViewController
        
        let containerVC = ContainerViewController(sideMenu: menuVC, center: centerNav)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = containerVC
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        return true
    }

}

