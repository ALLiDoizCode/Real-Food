//
//  Menu.swift
//  Real Food
//
//  Created by Jonathan Green on 2/11/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import ChameleonFramework

class getMenu {
    
    var menuView: BTNavigationDropdownMenu!
    
    func setupMenu(nav:UINavigationController){
        
        let items = ["Home", "Messages", "Following", "Profile", "Logout"]
        nav.navigationBar.translucent = false
        nav.navigationBar.barTintColor = UIColor.flatForestGreenColor()
        nav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        menuView = BTNavigationDropdownMenu(navigationController: nav, title: items.first!, items: items)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = UIColor.flatForestGreenColor()
        menuView.cellSelectionColor = UIColor.flatForestGreenColorDark()
        menuView.cellTextLabelColor = UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatForestGreenColor(), isFlat:true)
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .Left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.blackColor()
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
        }
        
        nav.navigationItem.titleView = menuView
    }
}
