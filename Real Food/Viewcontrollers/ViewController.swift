//
//  ViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 1/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
//import BTNavigationDropdownMenu
import ChameleonFramework
import Parse
import HanabiCollectionViewLayout

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    let cellIdentefier = "Menu"
    
    @IBOutlet weak var hanabiLayout: HanabiCollectionViewLayout!
    @IBOutlet weak var collectionVIew: UICollectionView!
    
    //var menuView: BTNavigationDropdownMenu!
    var sourceColor:UIColor!
    
    let presenter = PresentList()
    let menu = getMenu()
    
    let menuArray:[String] = ["Vegetable","Fruit-1","cheese","eggs","chicken","cow-1","goat-1","lamb-1","beer"]
    let menuName:[String] = ["Veggies","Sweets","Dariy","Eggs","Poultry","Bovine","Goat","Lamb","Beer"]
    var colors:[UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu.setupMenu(self,title: "Home")
        
        sourceColor = UIColor(complementaryFlatColorOf:UIColor.flatForestGreenColorDark())
        
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("food", sender: indexPath);
    
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "food" {
            
            let index = sender as! NSIndexPath
            
            let controller = segue.destinationViewController as! FoodViewController
            
            print(menuName[index.item])
            
            controller.type = menuName[index.item]
        }
        
        
    }

}

