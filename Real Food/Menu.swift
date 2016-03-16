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
    
    let presenter = PresentUser()
    
    func setupMenu(nav:UIViewController,title:String){
        
        let items = ["Home", "Messages", "Profile", "Logout"]
        nav.navigationController!.navigationBar.translucent = false
        nav.navigationController!.navigationBar.barTintColor = UIColor.flatForestGreenColor()
        nav.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.flatSandColorDark()]
        nav.navigationController!.navigationBar.tintColor = UIColor.flatSandColorDark()
        
        menuView = BTNavigationDropdownMenu(navigationController: nav.navigationController, title: title, items: items)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = UIColor.flatForestGreenColor()
        menuView.cellSelectionColor = UIColor.flatForestGreenColorDark()
        menuView.cellTextLabelColor = UIColor.flatSandColorDark()
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .Left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.blackColor()
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            
           
            
            if indexPath == 0 {
                
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                
                let controller = storyBoard.instantiateViewControllerWithIdentifier("Home") as! ViewController
                
                nav.navigationController!.pushViewController(controller, animated: true)
            }
            
            if indexPath == 1 {
                
                let storyBoard = UIStoryboard.init(name: "Chat", bundle: nil)
                
                let controller = storyBoard.instantiateViewControllerWithIdentifier("Chat") as! RoomsViewController
                
                nav.navigationController!.pushViewController(controller, animated: true)
            }
            
            if indexPath == 2 {
                
                let profile = UIStoryboard(name: "Profile", bundle: nil)
                let sellerProfile:SellerProfileViewController = profile.instantiateViewControllerWithIdentifier("SellerProfile") as! SellerProfileViewController
                nav.navigationController!.pushViewController(sellerProfile, animated: true)
            }
            
            if indexPath == 3 {
                
                self.presenter.logout()
                
                let storyBoard = UIStoryboard.init(name: "Login", bundle: nil)
                
                let controller = storyBoard.instantiateViewControllerWithIdentifier("landing") as! LandingViewController
                
                nav.navigationController!.pushViewController(controller, animated: true)
                
                
                
            }
        }
        
        nav.navigationItem.titleView = menuView
    }
}
