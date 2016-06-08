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
import TTGEmojiRate
import Cartography

class SellerViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    let menu = getMenu.sharedInstance
    let presenter = PresentMessages()
    let reuseIdentifier = "Review"
    
    var sellerId:String!
    var sellerIcon:String!
    var itemIcon:String!
    var sellerName:String!
    var sellerCity:String!
    var sellerDistance:String!
    var sellerRating:String!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var message: UIButton!
    @IBOutlet weak var rate: UIButton!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var rateValueLabel: MaterialLabel!
    var rateView:EmojiRateView!


    var menuView: BTNavigationDropdownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("my item \(sellerIcon)")
        
        mainImage.kf_setImageWithURL(NSURL(string: itemIcon)!, placeholderImage: UIImage(named: "placeholder"))
        userImage.kf_setImageWithURL(NSURL(string: sellerIcon)!, placeholderImage: UIImage(named: "placeholder"))
        userName.text = sellerName
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
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
          
            self.userName.font = RobotoFont.mediumWithSize(20)
            self.distance.font = RobotoFont.mediumWithSize(14)
            self.distance.text = "16m/MT Pleasent"
            
            self.ratingLbl.font = RobotoFont.mediumWithSize(16)
            
            let imageColor = UIColor(averageColorFromImage:self.mainImage.image)
            self.userImage.layer.borderColor = UIColor(complementaryFlatColorOf: imageColor).CGColor
            self.userImage.layer.borderWidth = 3
            
        });
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        menu.setupMenu(self,title:"Seller")
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        menu.menuView.hide()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func messageBTn(sender: AnyObject) {
        
        print("the seller Id is \(sellerId)")
        
        presenter.sendMessage("", recipient: sellerId) { (success) -> Void in
            
            if success == true {
                
                self.performSegueWithIdentifier("goToMessages", sender: self)
            }
        }
        
        self.performSegueWithIdentifier("goToMessages", sender: self)
    }
    
    
    
    @IBAction func rateBtn(sender: AnyObject) {
        
        rateView = EmojiRateView()
        rateValueLabel = MaterialLabel()
        
        let ratingTexts = ["Very bad", "Bad", "Normal", "Good", "Very good", "Perfect"]
        
        let doneBtn = MaterialButton()
        doneBtn.setTitle("Rate", forState: UIControlState.Normal)
        doneBtn.backgroundColor = rate.backgroundColor
        doneBtn.cornerRadius = .Radius1
        
        let bgView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        bgView.backgroundColor = UIColor.flatSandColorDark()
        rateValueLabel.textColor = rate.backgroundColor
        rateValueLabel.textAlignment = .Center
        rateValueLabel.font = RobotoFont.mediumWithSize(20)
        rateView = EmojiRateView.init(frame: CGRectMake(0, 0, 300, 300))
        rateView.backgroundColor = UIColor.clearColor()
        rateView.center = self.view.center
        rateView.rateColorRange = (message.backgroundColor!,rate.backgroundColor!)
        bgView.addSubview(rateView)
        bgView.addSubview(rateValueLabel)
        bgView.addSubview(doneBtn)
        self.view.addSubview(bgView)
        
        rateView.rateValueChangeCallback = {(rateValue: Float) -> Void in
            self.rateValueLabel.text = String(
                format: "%.2f / 5.0, %@",
                rateValue, ratingTexts[Int(rateValue)])
        }
        
        constrain(rateView,rateValueLabel,doneBtn) { rateView,rateValueLabel,doneBtn  in
            
            rateView.center == (rateView.superview?.center)!
            rateView.width == (rateView.superview?.width)! - 20
            rateView.height == rateView.width
            
            rateValueLabel.centerX == (rateValueLabel.superview?.centerX)!
            rateValueLabel.bottom == rateView.top
            rateValueLabel.height == 100
            rateValueLabel.width == 300
            
            doneBtn.centerX == (doneBtn.superview?.centerX)!
            doneBtn.bottom == doneBtn.superview!.bottom - 20
            doneBtn.width == 200
            doneBtn.height == 50
            
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "goToMessages" {
            
            let controller = segue.destinationViewController as! ChatRoomViewController
            controller.sellerId = sellerId
            
            print("the object id is \(sellerId)")
        }
    }
    
    

}
