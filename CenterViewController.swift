//
//  CenterViewController.swift
//  SideMenuDemo
//
//  Created by Eric Hodgins on 2016-11-26.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit
import QuartzCore

class CenterViewController: UIViewController {
    
    var menuButton: MenuButton!
    var menuItem: MenuItem! {
        didSet {
            view.backgroundColor = menuItem.color
            menuContent.text = menuItem.title
            setupGradientLayer()
            animateBackgroundColor()
        }
    }
    
    @IBOutlet weak var menuContent: UILabel!

    
    var gradientLayer: CAGradientLayer!
    

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
        
        menuItem = MenuItem.sharedItems.first!
        
    }
    
    override func viewDidLayoutSubviews() {
        view.layer.insertSublayer(gradientLayer, below: menuContent.layer)
    }
    
    func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let colors = [menuItem.color.cgColor, UIColor.white.cgColor, menuItem.color.cgColor]
        gradientLayer.colors = colors
        
        let locations: [NSNumber] = [0.25, 0.5, 0.75]
        gradientLayer.locations = locations
        
        gradientLayer.frame = CGRect(x: -view.bounds.size.width, y: view.bounds.origin.y, width: 4 * view.bounds.size.width, height: view.bounds.size.height)
    }

    func animateBackgroundColor() {
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0, 0, 0.25]
        gradientAnimation.toValue = [0.75, 1.0, 1.0]
        gradientAnimation.duration = 5.0
        gradientAnimation.repeatCount = .infinity
        
        gradientLayer.add(gradientAnimation, forKey: nil)
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
