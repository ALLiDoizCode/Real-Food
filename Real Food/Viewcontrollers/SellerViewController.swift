//
//  SellerViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 1/27/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material
import FXBlurView
import BTNavigationDropdownMenu

class SellerViewController: UIViewController{
    
    let menu = getMenu()
    
    let reuseIdentifier = "Seller"


    @IBOutlet weak var locationView: UIView!
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
 
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var mainDescription: UILabel!
    @IBOutlet weak var imageDescription: UILabel!

    var menuView: BTNavigationDropdownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenu()
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.userImage.layer.cornerRadius = self.userImage.layer.frame.height/2
            self.userImage.layer.masksToBounds = true
            
            self.locationView.layer.borderWidth = 0.5
            self.locationView.layer.borderColor = UIColor.flatGrayColor().CGColor
            self.locationView.layer.masksToBounds = true
            
            //self.navigationController?.navigationBarHidden = true
            
            //self.mainView.backgroundColor = UIColor.flatCoffeeColorDark()
            
            self.view.backgroundColor = UIColor.flatCoffeeColorDark()
            
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
            layout.itemSize = CGSize(width: UIScreen().bounds.width/3, height: UIScreen().bounds.width/3)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            
            self.mainView.layer.cornerRadius = 3
            self.mainView.layer.masksToBounds = true
            self.mainImage.image = UIImage(named: "beans")
            let blurredImage = self.mainImage.image?.blurredImageWithRadius(40, iterations: 2, tintColor: UIColor.clearColor())
            self.mainImage.image = blurredImage
            self.imageDescription.text = "100 Mile Diet For Global Change."
            self.mainDescription.text  = "1oifjsdoifsdofjsdoifjsdoifjsdoifjsdofjsdoifjsdoifjdsoifjhsdouifghjsdougjhdsouigjhsdofjdsoifjsdoifjsdoifjs"
            
            let imageColor = UIColor(averageColorFromImage:self.mainImage.image)
            
            self.imageDescription.font = RobotoFont.mediumWithSize(24)
            self.mainDescription.font = RobotoFont.lightWithSize(14)
            self.address.font = RobotoFont.lightWithSize(17)
            self.address.text = "1423 Moutain Hill Rd Springfield Washington 23348"
            self.userName.font = RobotoFont.mediumWithSize(24)
            self.userName.textColor = UIColor(contrastingBlackOrWhiteColorOn: imageColor, isFlat: true)
            self.userName.text = "Sara Dodsen"
            self.distance.textColor = UIColor.flatGrayColor()
            self.distance.font = RobotoFont.mediumWithSize(24)
            self.distance.text = "16m"
            
           
            self.userImage.layer.borderColor = UIColor(complementaryFlatColorOf: imageColor).CGColor
            self.userImage.layer.borderWidth = 3
            
            self.imageDescription.textColor = UIColor(complementaryFlatColorOf: imageColor)
            
            self.locationView.layoutSubviews()

        });
        
          }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupMenu(){
        
        let items = ["Home", "Messages", "Following", "Profile", "Logout"]
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.flatForestGreenColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: "Profile", items: items)
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
        
        self.navigationItem.titleView = menuView
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
