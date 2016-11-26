//
//  ContainerViewController.swift
//  SideMenuDemo
//
//  Created by Eric Hodgins on 2016-11-26.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    let sideMenuWidth: CGFloat = 80.0
    
    let menuViewController: UIViewController
    let centerViewController: UINavigationController
    
    
    init(sideMenu: UIViewController, center: UINavigationController) {
        menuViewController = sideMenu
        centerViewController = center
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been inmplemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add the center view controller
        addChildViewController(centerViewController)
        view.addSubview(centerViewController.view)
        centerViewController.didMove(toParentViewController: self)
        
        // Add the side menu view controller
        addChildViewController(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMove(toParentViewController: self)
        
        menuViewController.view.frame = CGRect(x: -sideMenuWidth, y: 0, width: sideMenuWidth, height: view.frame.height)
        
    }
    
    func toggleSideMenu() {
        
        let isMenuOpen = floor(centerViewController.view.frame.origin.x / sideMenuWidth) == 1 ? true : false // less than 1 is Closed. Equal to 1 is Open
        let moveX = isMenuOpen ? -sideMenuWidth : sideMenuWidth
        
        UIView.animate(withDuration: 0.4, animations: {
            self.menuViewController.view.frame.origin.x += moveX
            self.centerViewController.view.frame.origin.x += moveX
            
        }, completion: {_ in
        
        })
        
    }

}
