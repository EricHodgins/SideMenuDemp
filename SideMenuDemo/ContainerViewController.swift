//
//  ContainerViewController.swift
//  SideMenuDemo
//
//  Created by Eric Hodgins on 2016-11-26.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
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

        // Do any additional setup after loading the view.
    }

}
