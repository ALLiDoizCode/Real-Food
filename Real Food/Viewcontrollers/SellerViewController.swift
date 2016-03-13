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

class SellerViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    let menu = getMenu()
    
    @IBOutlet weak var tableView: UITableView!
    let reuseIdentifier = "Review"
    
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var message: UIButton!
    @IBOutlet weak var rate: UIButton!
    @IBOutlet weak var distance: UILabel!
 
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
 
    @IBOutlet weak var userName: UILabel!


    var menuView: BTNavigationDropdownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.setupMenu()
        
        self.rate.backgroundColor = UIColor.flatForestGreenColor()
        self.message.backgroundColor = UIColor(complementaryFlatColorOf: self.rate.backgroundColor)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.ratingLbl.layer.cornerRadius = self.ratingLbl.layer.frame.height/2
            self.ratingLbl.layer.masksToBounds = true
            
            self.mainView.layoutSubviews()
            
            self.rate.layer.cornerRadius = 3
            self.rate.layer.masksToBounds = true
            
            self.message.layer.cornerRadius = 3
            self.message.layer.masksToBounds = true
    
            self.userImage.layer.cornerRadius = self.userImage.layer.frame.height/2
            self.userImage.layer.masksToBounds = true
            
            self.view.backgroundColor = UIColor.flatSandColorDark()
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
            layout.itemSize = CGSize(width: UIScreen().bounds.width/3, height: UIScreen().bounds.width/3)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            
            self.mainImage.image = UIImage(named: "beans")
            //let blurredImage = self.mainImage.image?.blurredImageWithRadius(40, iterations: 2, tintColor: UIColor.clearColor())
            //self.mainImage.image = blurredImage
            //self.mainImage.layer.cornerRadius = 3
        
            let imageColor = UIColor(averageColorFromImage:self.mainImage.image)
          
            self.userName.font = RobotoFont.mediumWithSize(20)
            //self.userName.textColor = UIColor(contrastingBlackOrWhiteColorOn: imageColor, isFlat: true)
            self.userName.text = "Sara Dodsen"
            //self.distance.textColor = UIColor.flatGrayColor()
            self.distance.font = RobotoFont.mediumWithSize(14)
            self.distance.text = "16m/MT Pleasent"
            
            self.ratingLbl.font = RobotoFont.mediumWithSize(16)
            
            self.userImage.layer.borderColor = UIColor(complementaryFlatColorOf: imageColor).CGColor
            self.userImage.layer.borderWidth = 3
            

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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ReviewCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! ReviewCell
        
        cell.reviewLbl.text = "She had the best tasting sweet potatoes I've ever had and her graden is just beutiful"
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}