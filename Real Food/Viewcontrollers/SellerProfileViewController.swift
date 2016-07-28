//
//  SellerProfileViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 2/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import FXBlurView
import Material
import ImagePickerSheetController
import Photos
import SwiftSpinner
import Kingfisher
import Cartography

class SellerProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    let menu = getMenu.sharedInstance
    let presenter = PresentList()
    let presentUser = PresentUser()
    let presentEditor = PresenterEditing()

    let controller = UIImagePickerController()
    
    let cellIdentefier = "Food"
    
    var edit:UIButton!
    
    var type:String!
    var image:UIImage!
    var itemsArray:[Item] = []
    var myReviews:[Review] = []

    @IBOutlet weak var ratingTable: UITableView!
    @IBOutlet weak var rating: FabButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var closeReview: RaisedButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.delegate = self
        
        edit = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        edit.setTitle("Edit", forState: UIControlState.Normal)
        edit.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
        edit.addTarget(self, action: #selector(SellerProfileViewController.goEdit), forControlEvents: UIControlEvents.TouchUpInside)
    
        menu.setupMenu(self,title: "Profile")
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.flatSandColorDark()
        
        self.bgImage.clipsToBounds = true
        
          dispatch_async(dispatch_get_main_queue(), {
            
            self.setupLayouts()
        
            self.userImage.layer.cornerRadius = self.userImage.layer.frame.height/2
            self.userImage.layer.borderColor = UIColor.flatSandColorDark().CGColor
            self.userImage.layer.borderWidth = 3
            
            self.userName.font = RobotoFont.mediumWithSize(14)
            
            self.userImage.layer.masksToBounds = true
            self.userImage.clipsToBounds = true
            
        });
        
        closeReview.setTitle("Close", forState: .Normal)
        closeReview.titleLabel!.font = RobotoFont.mediumWithSize(32)
        closeReview.backgroundColor = UIColor.flatPlumColorDark()
        closeReview.setTitleColor(UIColor.flatSandColorDark(), forState: .Normal)
        
        rating.backgroundColor = UIColor.clearColor()
        rating.tintColor = UIColor.flatWhiteColor()
        rating.setTitle("", forState: UIControlState.Normal)
        rating.titleLabel?.font = RobotoFont.mediumWithSize(32)
        
        let rightButton = UIBarButtonItem.init(customView: edit)
        
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        ratingTable.hidden = true
        closeReview.hidden = true
        
        /*presenter.getMyItems { (data) -> Void in
            
            print("got data")
            
            print(data.count)
            
            self.itemsArray = []
            
            self.itemsArray = data
            
            self.reload(self.tableView)
            
            self.ratingTable.estimatedRowHeight = 44
            self.ratingTable.rowHeight = UITableViewAutomaticDimension
        }
        
        presentUser.getReviews((presentUser.currentUser?.objectId)!) { (data, Rating) in
            
            self.myReviews = data
            
            if self.myReviews.count < 1 {
                
                self.rating.hidden = true
                
            }else {
                
                self.rating.hidden = false
            }
            
            self.rating.setTitle(Rating, forState: UIControlState.Normal)
        }
        
        
        presentUser.userData { (data) in
            
            self.bgImage.kf_setImageWithURL(NSURL(string: data.profileImage)!, placeholderImage: UIImage(), options: .None, completionHandler: { (image, error, cacheType, imageURL) in
                
                self.bgImage.image = image?.blurredImageWithRadius(100, iterations: 2, tintColor: UIColor.blackColor())
                
            })
            self.userImage.kf_setImageWithURL(NSURL(string: data.profileImage)!, placeholderImage: UIImage(named: "placeholder"))
            self.userName.text = data.userName
            
        }*/
    }
    
    override func viewDidAppear(animated: Bool) {
        
        presenter.getMyItems { (data) -> Void in
            
            print("got data")
            
            print(data.count)
            
            self.itemsArray = []
            
            self.itemsArray = data
            
            self.reload(self.tableView)
            
            self.ratingTable.estimatedRowHeight = 44
            self.ratingTable.rowHeight = UITableViewAutomaticDimension
        }
        
        presentUser.getReviews((presentUser.currentUser?.objectId)!) { (data, Rating) in
            
            self.myReviews = data
            
            if self.myReviews.count < 1 {
                
                self.rating.hidden = true
                
            }else {
                
                self.rating.hidden = false
            }
            
            self.rating.setTitle(Rating, forState: UIControlState.Normal)
        }
        
        
        presentUser.userData { (data) in
            
            self.bgImage.kf_setImageWithURL(NSURL(string: data.profileImage)!, placeholderImage: UIImage(), options: .None, completionHandler: { (image, error, cacheType, imageURL) in
                
                self.bgImage.image = image?.blurredImageWithRadius(100, iterations: 2, tintColor: UIColor.blackColor())
                
            })
            self.userImage.kf_setImageWithURL(NSURL(string: data.profileImage)!, placeholderImage: UIImage(named: "placeholder"))
            self.userName.text = data.userName
            
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        
        menu.menuView.hide()
        
    }
    
    func setupLayouts(){
        
        constrain(tableView,bgImage) { tableView,bgImage in
            
            tableView.width == (tableView.superview?.width)!
            tableView.left == (tableView.superview?.left)!
        }
    }
    
    @IBAction func ratingBtn(sender: AnyObject) {
        
        self.ratingTable.hidden = false
        self.ratingTable.dataSource = self
        self.ratingTable.delegate = self
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        self.closeReview.hidden = false
        
        self.reload(self.ratingTable)
        
    }
    
    @IBAction func closeReviewBtn(sender: AnyObject) {
        
        ratingTable.hidden = true
        ratingTable.dataSource = nil
        ratingTable.delegate = nil
        tableView.delegate = self
        tableView.dataSource = self
        closeReview.hidden = true
        
        reload(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if ratingTable.hidden == false {
            
            print("we have \(myReviews.count) reviews")
            
            return myReviews.count
            
        }else {
            
            return itemsArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if ratingTable.hidden == false {
            
            let cell:ReviewCell2 = tableView.dequeueReusableCellWithIdentifier("Review2") as! ReviewCell2
            
            dispatch_async(dispatch_get_main_queue(), {
                
                print("we now have \(self.myReviews.count) reviews")

                cell.review.text = self.myReviews[indexPath.row].review
                cell.rate.text = String(self.myReviews[indexPath.row].rate)
                cell.user.text = self.myReviews[indexPath.row].user
                
                cell.layoutSubviews()
            });
            
            return cell
            
        }else {
            
            let cell:FoodCell = tableView.dequeueReusableCellWithIdentifier(cellIdentefier) as! FoodCell
            
            dispatch_async(dispatch_get_main_queue(), {
                
                let image = self.itemsArray[indexPath.row].image
                
                cell.cellImage.kf_setImageWithURL(NSURL(string: image)!, placeholderImage: UIImage(named: "placeholder"))
                cell.mainLabel.text = self.itemsArray[indexPath.row].name
                cell.foodDescription.text = self.itemsArray[indexPath.row].description
                cell.userIcon.image = UIImage(named: self.itemsArray[indexPath.row].name)
                cell.userIcon.layer.cornerRadius = 0
                cell.distanceView.hidden = true
                
                cell.layoutSubviews()
            });
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if ratingTable.hidden == true {
            
            if editingStyle == .Delete {
                
                self.type = self.itemsArray[indexPath.row].type
                let objectId = self.itemsArray[indexPath.row].objectId
                
                print(objectId)
                self.itemsArray.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                presentEditor.delteObject(self.type, itemId: objectId, completion: { (success) in
                    
                    if success == true {
                        print("Alert User")
                    }else {
                        print("Alert User")
                    }
                })
                
            } else if editingStyle == .Insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if ratingTable.hidden == true {
            
            return 250
            
        }else {
            
            return ratingTable.rowHeight
        }
    }
    
    func reload(table:UITableView){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            table.reloadData()
        })
    }
    
    func goEdit(){
        
        self.performSegueWithIdentifier("Edit", sender: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Edit" {
            
            let controller = segue.destinationViewController as! EditProfileViewController
            controller.image = userImage.image
        }
    }
}
