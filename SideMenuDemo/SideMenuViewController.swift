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
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / CGFloat(MenuItem.sharedItems.count)
    }
}
