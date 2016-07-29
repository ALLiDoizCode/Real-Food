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
    //let presenter = PresentMessages()
    let reuseIdentifier = "Review"
    //let presentUser = PresentUser()
    
    var sellerPhone:String!
    var sellerId:String!
    var sellerIcon:UIImage!
    var itemIcon:UIImage!
    var sellerName:String!
    var sellerCity:String!
    var sellerDistance:String!
    var sellerRating:String!
    var rating:Int!
    var reviewDescription:String!
    var reviews:[Review] = []
    
    var reveiewList = MakeReview()
    
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
    var bgView:UIView!
    var review:TextView!
    var doneBtn:MaterialButton!
    var reviewLbl:MaterialLabel!
    var reviewIcon:UIImageView!

    var menuView: BTNavigationDropdownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingLbl.text = "4.0"
        
        reviews = reveiewList.getReviews()
        
        review = TextView()
        reviewLbl = MaterialLabel()
        reviewIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        message.setTitle("Call", forState: UIControlState.Normal)
        
         bgView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        
        print("my item \(sellerIcon)")
        
        mainImage.image = itemIcon
        userImage.image = UIImage(named: "girl")
        userName.text = sellerName
        
        reviewIcon.image = userImage.image
        reviewIcon.contentMode = .ScaleAspectFill
        
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
            self.distance.text = "\(self.sellerDistance)m from your location"
            
            self.ratingLbl.font = RobotoFont.mediumWithSize(16)
            
            let imageColor = UIColor(averageColorFromImage:self.mainImage.image)
            self.userImage.layer.borderColor = UIColor(complementaryFlatColorOf: imageColor).CGColor
            self.userImage.layer.borderWidth = 3
            
            self.makeRateView()
            
        });
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        menu.setupMenu(self,title:"Seller")
        review.hidden = true
        reviewIcon.hidden = true
        reviewLbl.hidden = true
        bgView.hidden =  true
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
    
    func reload(){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.tableView.reloadData()
        });
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return reviews.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ReviewCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! ReviewCell
        
        cell.reviewLbl.text = self.reviews[indexPath.row].review
        cell.reviewRate.text = "\(self.reviews[indexPath.row].rate)"
        cell.reviewer.text = self.reviews[indexPath.row].user
        
        return cell
    }
    
    @IBAction func messageBTn(sender: AnyObject) {
        
        if let url = NSURL(string: "telprompt://\(sellerPhone)")
        {
            UIApplication.sharedApplication().openURL(url)
        }
        
    }
    
    func makeRateView(){
        
        bgView.hidden =  true
        
        rateView = EmojiRateView()
        rateValueLabel = MaterialLabel()
        
        reviewLbl.text = "Reivew"
        reviewLbl.textColor = rate.backgroundColor
        reviewLbl.font = RobotoFont.boldWithSize(50)
        reviewLbl.textAlignment = .Center
        
        review.font = RobotoFont.mediumWithSize(20)
        review.titleLabel?.text = "Leave a Review"
        review.clipsToBounds = true
        
        let ratingTexts = ["Very bad", "Bad", "Normal", "Good", "Very good", "Perfect"]
        
        doneBtn = MaterialButton()
        doneBtn.setTitle("Rate", forState: UIControlState.Normal)
        doneBtn.backgroundColor = rate.backgroundColor
        doneBtn.cornerRadius = .Radius1
        doneBtn.addTarget(self, action:#selector(SellerViewController.ratingDone), forControlEvents: UIControlEvents.TouchUpInside)
        
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
        bgView.addSubview(review)
        bgView.addSubview(reviewLbl)
        bgView.addSubview(reviewIcon)
        self.view.addSubview(bgView)
        
        rateView.rateValueChangeCallback = {(rateValue: Float) -> Void in
            
            self.rating = Int(rateValue)
            
            self.rateValueLabel.text = String(
                format: "%.2f / 5.0, %@",
                rateValue, ratingTexts[Int(rateValue)])
        }
        
        constrain(rateView,rateValueLabel,doneBtn,review,reviewLbl) { rateView,rateValueLabel,doneBtn,review,reviewLbl  in
            
            rateView.center == (rateView.superview?.center)!
            rateView.width == (rateView.superview?.width)! - 20
            rateView.height == rateView.width
            
            rateValueLabel.centerX == (rateValueLabel.superview?.centerX)!
            rateValueLabel.bottom == rateView.top
            rateValueLabel.height == 100
            rateValueLabel.width == 300
            
            review.center == (review.superview?.center)!
            review.width == 300
            review.height == 150
            
            doneBtn.centerX == (doneBtn.superview?.centerX)!
            doneBtn.bottom == doneBtn.superview!.bottom - 60
            doneBtn.width == 200
            doneBtn.height == 50
            
            reviewLbl.centerX == (reviewLbl.superview?.centerX)!
            reviewLbl.width == 300
            reviewLbl.height == 100
            reviewLbl.bottom == review.top + 30
        }
        
        constrain(reviewIcon) { reviewIcon in
            
            reviewIcon.centerX == (reviewIcon.superview?.centerX)!
            reviewIcon.top == (reviewIcon.superview?.top)! + 30
            reviewIcon.width == 100
            reviewIcon.height == 100
            
            self.reviewIcon.layer.cornerRadius = 50
            self.reviewIcon.layer.masksToBounds = true
            self.reviewIcon.clipsToBounds = true
        }
    }

    func ratingDone(){
        print("Boom2")
        self.doneBtn.setTitle("Done", forState: UIControlState.Normal)
        self.reviewIcon.hidden = false
        self.review.hidden = false
        self.reviewLbl.hidden = false
        self.rateView.hidden = true
        self.rateValueLabel.hidden = true
    }
    
    @IBAction func rateBtn(sender: AnyObject) {
        
         print("Boom")
        bgView.hidden =  false
        reviewIcon.hidden = true
        review.hidden = true
        rateView.hidden = false
        rateValueLabel.hidden = false
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goToMessages" {
            
            let controller = segue.destinationViewController as! ChatRoomViewController
            controller.sellerId = sellerId
            
            print("the object id is \(sellerId)")
        }
    }

}
