//
//  MenuItem.swift
//  SideMenuDemo
//
//  Created by Eric Hodgins on 2016-11-26.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit

class MenuItem {
    let title: String
    let color: UIColor
    
    init(title: String, color: UIColor) {
        self.title = title
        self.color = color
    }
    
    class func demoItems(numberOfItems: Int) -> [MenuItem] {
        var items = [MenuItem]()
        
        for i in 1...numberOfItems {
            let item = MenuItem(title: "\(i)", color: UIColor.randomColor())
            items.append(item)
        }
        
        return items
    }
}


extension UIColor {
    class func randomColor() -> UIColor {
        let randomRed = CGFloat(arc4random_uniform(10)) / 10.0
        let randomGreen = CGFloat(arc4random_uniform(10)) / 10.0
        let randomBlue = CGFloat(arc4random_uniform(10)) / 10.0
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
