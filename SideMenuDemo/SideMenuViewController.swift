//
//  SideMenuViewController.swift
//  SideMenuDemo
//
//  Created by Eric Hodgins on 2016-11-26.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit

class SideMenuViewController: UITableViewController {
    
    var centerViewController: CenterViewController!
    let circleLayer = CAShapeLayer()

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItem.sharedItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! SideMenuTableViewCell

        let menuItem = MenuItem.sharedItems[indexPath.row]
        cell.title?.text = menuItem.title
        cell.backgroundColor = menuItem.color
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row at index: \(indexPath.row)")
        
        centerViewController.menuItem = MenuItem.sharedItems[indexPath.row]
        
        let containerViewController = parent as! ContainerViewController
        containerViewController.toggleSideMenu()
        
        let cell = tableView.cellForRow(at: indexPath)
        let cellBounds = cell!.contentView.bounds
        var rect = CGRect()
        rect.size = CGSize(width: cellBounds.size.width/4, height: cellBounds.size.height/4)
        rect.origin.x = cell!.contentView.center.x - rect.size.width/2
        rect.origin.y = cell!.contentView.center.y - rect.size.height/2
        circleLayer.path = UIBezierPath(ovalIn: rect).cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.fillColor = UIColor.white.cgColor
        cell?.contentView.layer.addSublayer(circleLayer)
        
        let morphCircleAnim = CABasicAnimation(keyPath: "path")
        morphCircleAnim.delegate = self
        morphCircleAnim.setValue(circleLayer, forKey: "layer")
        morphCircleAnim.autoreverses = true
        morphCircleAnim.duration = 0.1
        morphCircleAnim.toValue = UIBezierPath(ovalIn: cellBounds).cgPath
        
        circleLayer.add(morphCircleAnim, forKey: nil)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / CGFloat(MenuItem.sharedItems.count)
    }
}

extension SideMenuViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let circleLayer = anim.value(forKey: "layer") as? CALayer
        anim.setValue(nil, forKey: "layer")
        circleLayer?.removeFromSuperlayer()
    }
}
