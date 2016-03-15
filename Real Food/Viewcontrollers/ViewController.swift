//
//  ViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 1/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import ChameleonFramework
import Parse

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    let cellIdentefier = "Menu"
    
    let veggies = "Veggies"
    let sweets = "Sweets"
    let poultry = "Poultry"
    let lamb = "Lamb"
    let goat = "Goat"
    let eggs = "Eggs"
    let dariy = "Dariy"
    let bovine = "Bovine"
    let beer = "Beer"
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    
    var menuView: BTNavigationDropdownMenu!
    var sourceColor:UIColor!
    
    let presenter = PresentList()
    
    let menuArray:[String] = ["Vegetable","Fruit-1","cheese","eggs","chicken","cow-1","goat-1","lamb-1","beer"]
    let menuName:[String] = ["Veggies","Sweets","Dariy","Eggs","Poultry","Bovine","Goat","Lamb","Beer"]
    var colors:[UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupMenu()
        
        self.view.backgroundColor = menuView.cellBackgroundColor
        
        sourceColor = UIColor(complementaryFlatColorOf:menuView.cellBackgroundColor)
        
        for var i = 0; i < menuArray.count; i++ {
            
            sourceColor = UIColor(complementaryFlatColorOf:sourceColor)
            
            colors.append(sourceColor)
        }
        
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupMenu(){
        
        let items = ["Home", "Messages", "Profile", "Logout"]
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.flatForestGreenColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.flatSandColor()]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items.first!, items: items)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = UIColor.flatForestGreenColor()
        menuView.cellSelectionColor = UIColor.flatForestGreenColorDark()
        //menuView.cellTextLabelColor = UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatForestGreenColor(), isFlat:true)
        menuView.cellTextLabelColor = UIColor.flatSandColor()
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .Left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.blackColor()
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            
            let profile = UIStoryboard(name: "Profile", bundle: nil)
            let sellerProfile:SellerProfileViewController = profile.instantiateViewControllerWithIdentifier("SellerProfile") as! SellerProfileViewController
            
            if indexPath == 2 {
                
                self.navigationController?.pushViewController(sellerProfile, animated: true)
            }
            
            if indexPath == 3 {
                
                let storyBoard = UIStoryboard.init(name: "Login", bundle: nil)
                
                let controller = storyBoard.instantiateViewControllerWithIdentifier("landing") as! LandingViewController
                
                self.navigationController?.pushViewController(controller, animated: true)
                
            }
        }
        
        self.navigationItem.titleView = menuView
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return menuArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:MenuCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentefier, forIndexPath: indexPath) as! MenuCell
        
        let image = UIImage(named: menuArray[indexPath.row])
        
        
        dispatch_async(dispatch_get_main_queue(), {
            
            cell.backgroundColor = self.colors[indexPath.row]
            cell.bgImage.image = image
            cell.Name.text = self.menuName[indexPath.row]
            //cell.Name.textColor = UIColor(contrastingBlackOrWhiteColorOn:self.colors[indexPath.row], isFlat:true)
            cell.Name.textColor = UIColor.flatSandColor()
            cell.subName.text = self.menuName[indexPath.row]
            //cell.subName.textColor = UIColor(contrastingBlackOrWhiteColorOn:self.colors[indexPath.row], isFlat:true)
            cell.subName.textColor = UIColor.flatSandColor()
        });
        
        return cell
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}

