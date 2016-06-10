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
    let profileViews = ProfileViews()
    let getImage = GetImage()
    
    let controller = UIImagePickerController()
    
    let cellIdentefier = "Food"
    
    var edit:UIButton!
    
    var type:String!
    var image:UIImage!
    var itemsArray:[Item] = []
    var myReviews:[Review] = []

    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var cancle: FabButton!
    @IBOutlet weak var camera: FabButton!
    @IBOutlet weak var addItem: FabButton!
    @IBOutlet weak var cover: UIView!
    @IBOutlet weak var ratingTable: UITableView!
    @IBOutlet weak var rating: FabButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var addButton: FabButton!
    @IBOutlet weak var closeReview: RaisedButton!
    @IBOutlet weak var newItemView: UIView!
    @IBOutlet weak var newItemImage: UIImageView!
    
    @IBOutlet weak var veggie: FabButton!
    @IBOutlet weak var sweets: FabButton!
    @IBOutlet weak var dariy: FabButton!
    @IBOutlet weak var eggs: FabButton!
    @IBOutlet weak var poultry: FabButton!
    @IBOutlet weak var bovine: FabButton!
    @IBOutlet weak var goat: FabButton!
    @IBOutlet weak var lamb: FabButton!
    @IBOutlet weak var beer: FabButton!
    
    var itemTitle:TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.delegate = self
        
        edit = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        itemTitle = TextField(frame: CGRectMake(10, self.newItemView.bounds.height + 70, self.newItemView.frame.width + 100 , 24))
        
        newItemView.hidden = true
        
        self.newItemView.layer.cornerRadius = 3
        self.newItemView.layer.masksToBounds = true
        
        menu.setupMenu(self,title: "Profile")
        
        profileViews.makeButton(veggie, sweets: sweets, dariy: dariy, eggs: eggs, poultry: poultry, bovine: bovine, goat: goat, lamb: lamb, beer: beer, addButton: addButton, rating: rating, closeReview: closeReview, camera: camera, addItem: addItem, cancle: cancle, edit: edit, controller: self) { (veggie, sweets, dariy, eggs, poultry, bovine, goat, lamb, beer, addButton, rating, closeReview, camera, addItem, cancle, edit) in
            
            edit.addTarget(self, action: "goEdit", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        profileViews.makeTextFields(itemTitle, controller: self)
        
        self.navigationController?.navigationBar.tintColor = UIColor.flatSandColorDark()
        
        self.bgImage.clipsToBounds = true
        
          dispatch_async(dispatch_get_main_queue(), {
            
            self.setupLayouts()
        
            self.userImage.layer.cornerRadius = self.userImage.layer.frame.height/2
            self.userImage.layer.borderColor = UIColor.flatSandColorDark().CGColor
            self.userImage.layer.borderWidth = 3
            
            self.userName.font = RobotoFont.mediumWithSize(14)
            self.userName.text = "Sara"
            
            self.userImage.layer.masksToBounds = true
            self.userImage.clipsToBounds = true
            
        });
    }
    
    override func viewWillAppear(animated: Bool) {
        
        ratingTable.hidden = true
        cover.hidden = true
        closeReview.hidden = true
        buttonView.hidden = true
        
        presenter.getMyItems { (data) -> Void in
            
            print("got data")
            
            print(data.count)
            
            self.itemsArray = []
            
            self.itemsArray = data
            
            self.reload(self.tableView)
        }
        
        presentUser.getReviews((presentUser.currentUser?.objectId)!) { (data, Rating) in
            
            self.myReviews = data
            
            self.rating.setTitle(Rating, forState: UIControlState.Normal)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
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
        
        return 250
    }
    
    func reload(table:UITableView){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            table.reloadData()
        })
    }
    
    func goEdit(){
        
        self.performSegueWithIdentifier("Edit", sender: nil)
    }
    
    @IBAction func add(sender: AnyObject) {
        
        buttonView.hidden = false
        cover.hidden = false
    }
  
    @IBAction func addItemBtn(sender: AnyObject) {
        
        guard (image != nil) else {
            
            return
        }
        
        guard (itemTitle.text != nil) else {
            
            return
        }
        
         SwiftSpinner.show("Adding Item")
        
        presenter.makeItem(type, name: itemTitle.text!, image: image) { (success) -> Void in
            
            if success == true {
                
                    print("Item Saved Successfully")
                    self.newItemView.hidden = true
                    self.cover.hidden = true
                    
                    self.presenter.getMyItems { (data) -> Void in
                        
                        self.itemsArray.removeAll()
                        
                        self.itemsArray = data
                        
                        self.reload(self.tableView)
                        
                        SwiftSpinner.hide()
                        
                    }
                
                
            }else {
                
                SwiftSpinner.hide({
                    
                    print("There was an issue saving your item")
                })
                
            }
        }
        
    }
    
    @IBAction func cameraBtn(sender: AnyObject) {
        
        getImage.getImage(self, theController: controller) { (image) in
            
            self.newItemImage.image = image
            self.image = image
        }
        
    }
    
    @IBAction func cancelBtn(sender: AnyObject) {
        
        newItemView.hidden = true
        cover.hidden = true
    }
    
    @IBAction func ratingBtn(sender: AnyObject) {
        
        self.ratingTable.hidden = false
        self.ratingTable.dataSource = self
        self.ratingTable.delegate = self
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        self.cover.hidden = false
        self.closeReview.hidden = false
        
        self.reload(self.ratingTable)
        
    }
    
    @IBAction func closeReviewBtn(sender: AnyObject) {
        
        ratingTable.hidden = true
        ratingTable.dataSource = nil
        ratingTable.delegate = nil
        tableView.delegate = self
        tableView.dataSource = self
        cover.hidden = true
        closeReview.hidden = true
        
        reload(tableView)
    }
    
    func chooseCategory() {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        
        getImage.getImage(self, theController: controller) { (image) in
            
            self.newItemImage.image = image
            self.image = image
        }
    }
    
    @IBAction func veggieBtn(sender: AnyObject) {
        
        type = VEGGIES
        
        chooseCategory()

    }
    
    @IBAction func sweetsBtn(sender: AnyObject) {
    
        type = SWEETS
        
        chooseCategory()
    }
    
    @IBAction func dairyBtn(sender: AnyObject) {
    
        type = DARIY
        
        chooseCategory()
    }
    
    @IBAction func eggsBtn(sender: AnyObject) {
        
        type = EGGS
        
        chooseCategory()
    }
    
    @IBAction func poultryBtn(sender: AnyObject) {
        
        type = POULTRY
        
        chooseCategory()
    }
    
    @IBAction func bovineBtn(sender: AnyObject) {
        
        type = BOVINE
        
        chooseCategory()
    }
    
    @IBAction func goatBtn(sender: AnyObject) {
        
        type = GOAT
        
        chooseCategory()
    }
    
    @IBAction func lambBtn(sender: AnyObject) {
        
        type = LAMB
        
        chooseCategory()
    }
    
    @IBAction func beerBtn(sender: AnyObject) {
        
        type = BEER
        
        chooseCategory()
    }
    
    
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
       picker.dismissViewControllerAnimated(false) {
        
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        picker.dismissViewControllerAnimated(false) {
            
            self.newItemImage.image = image
            self.image = image
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
