//
//  ViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 1/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    let cellIdentefier = "Menu"
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    
    var menuView: BTNavigationDropdownMenu!
    
    let menuArray:[String] = ["vegetables","fruit","milk","chickens","cow","goat","lamb"]
    let menuName:[String] = ["Veggies","Sweets","Dariy","Poultry","Bovine","Goat","Lamb"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupMenu()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupMenu(){
        
        let items = ["Most Popular", "Latest", "Trending", "Nearest", "Top Picks"]
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items.first!, items: items)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuView.cellTextLabelColor = UIColor.whiteColor()
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .Left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.blackColor()
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
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
            
            cell.bgImage.image = image
            cell.Name.text = self.menuName[indexPath.row]
            
            if indexPath.row == 2 || indexPath.row == 5 {
                
                cell.Name.textColor = UIColor.grayColor()
                
            }else {
                
            }
            
        });
        
        return cell
    }


}

