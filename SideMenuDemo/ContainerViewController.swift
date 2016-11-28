//
//  ContainerViewController.swift
//  SideMenuDemo
//
//  Created by Eric Hodgins on 2016-11-26.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    let sideMenuWidth: CGFloat = 105.0
    var isOpening : Bool = false
    
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
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ContainerViewController.handleGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func handleGesture(_ recognizer: UIPanGestureRecognizer) {
        // Check if open or not
        var percent: CGFloat = 0
        
        let translation = recognizer.translation(in: recognizer.view!.superview!)
        
        if translation.x > -sideMenuWidth || translation.x < sideMenuWidth {
            percent = abs(translation.x) / sideMenuWidth * (isOpening ? 1 : -1)
        }
        
//        if translation.x >= 0 && translation.x < sideMenuWidth {
//            percent = (abs(translation.x) / sideMenuWidth) * (isOpening ? 1 : -1)
//        }
        
        switch recognizer.state {
        case .began:
            print("Began")
            let open = floor(centerViewController.view.frame.origin.x / sideMenuWidth)
            isOpening = open == 1.0 ? false : true
        case .changed:
            interActiveToggle(toPercent: percent)
        case .ended:
            let open = percent > 0.5 ? true : false
            interActiveToggleComplete(sideMenuCompleteToOpen: open)
            
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("failed")
        case .possible:
            print("possible`")
        }
    }
    
    func interActiveToggle(toPercent percent: CGFloat) {
        
        if isOpening {
            centerViewController.view.frame.origin.x = sideMenuWidth * percent
            menuViewController.view.frame.origin.x = (sideMenuWidth * percent) - sideMenuWidth
        } else {
            print(percent)
            centerViewController.view.frame.origin.x = sideMenuWidth + (sideMenuWidth * percent)
            menuViewController.view.frame.origin.x = sideMenuWidth * percent
        }
    }
    
    func interActiveToggleComplete(sideMenuCompleteToOpen open: Bool) {
        let moveCenterVCX = open ? sideMenuWidth : 0
        let moveMenuVCX = open ? 0 : -sideMenuWidth
        
        UIView.animate(withDuration: 0.4, animations: {
            self.centerViewController.view.frame.origin.x = moveCenterVCX
            self.menuViewController.view.frame.origin.x = moveMenuVCX
        })
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
