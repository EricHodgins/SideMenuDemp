//
//  CenterViewController.swift
//  SideMenuDemo
//
//  Created by Eric Hodgins on 2016-11-26.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {
    
    var menuButton: MenuButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton = MenuButton()
        
        menuButton.tapHandler = {
            // Toggle the side menu...need container view controller
            if let containerViewController = self.navigationController?.parent as? ContainerViewController {
                containerViewController.toggleSideMenu()
            }
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        navigationItem.title = "Side Menu Demo"
    }



}


class MenuButton: UIView {
    var imageView: UIImageView!
    var tapHandler: (() -> ())?
    
    override func didMoveToSuperview() {
        frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        imageView = UIImageView(image: UIImage(named: "menu.png"))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MenuButton.didTap)))
        addSubview(imageView)
    }
    
    func didTap() {
        tapHandler?()
    }
}
