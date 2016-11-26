//
//  CenterViewController.swift
//  SideMenuDemo
//
//  Created by Eric Hodgins on 2016-11-26.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



}


class MenuButton: UIView {
    var imageView: UIImageView!
    var tapHandler: (() -> ())?
    
    override func didMoveToSuperview() {
        frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        imageView = UIImageView(image: UIImage(named: "menu"))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MenuButton.didTap)))
    }
    
    func didTap() {
        tapHandler?()
    }
}
