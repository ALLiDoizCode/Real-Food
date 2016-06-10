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
    
    let cellIdentefier = "Food"
    
    var edit:UIButton!
    
    let VEGGIES = "Veggies"
    let SWEETS = "Sweets"
    let POULTRY = "Poultry"
    let LAMB = "Lamb"
    let GOAT = "Goat"
    let EGGS = "Eggs"
    let DARIY = "Dariy"
    let BOVINE = "Bovine"
    let BEER = "Beer"
    
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
    
    let imageArray:[String] = ["beans","carrots","cucumbers","greens","peas","peppers","tomatoes",]
    let titleArray:[String] = ["Beans","Carrots","Cucumbers","Greens","Peas","Peppers","Tomatoes",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edit = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        
        newItemView.hidden = true
        
        self.newItemView.layer.cornerRadius = 3
        self.newItemView.layer.masksToBounds = true
        
        menu.setupMenu(self,title: "Profile")
        
        profileViews.makeButton(veggie, sweets: sweets, dariy: dariy, eggs: eggs, poultry: poultry, bovine: bovine, goat: goat, lamb: lamb, beer: beer, addButton: addButton, rating: rating, closeReview: closeReview, camera: camera, addItem: addItem, cancle: cancle, edit: edit, controller: self) { (veggie, sweets, dariy, eggs, poultry, bovine, goat, lamb, beer, addButton, rating, closeReview, camera, addItem, cancle, edit) in
            
             edit.addTarget(self, action: "goEdit", forControlEvents: UIControlEvents.TouchUpInside)
            
        }
        makeTextFields()
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.flatSandColorDark()
        
         self.bgImage.clipsToBounds = true
        
          dispatch_async(dispatch_get_main_queue(), {
            
            self.setupLayouts()
            
            let blurredImage = self.bgImage.image?.blurredImageWithRadius(20, iterations: 2, tintColor: UIColor.clearColor())
            
            self.bgImage.image = blurredImage
           
            
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
        //newItemView.hidden = true
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
            
            self.bgImage.kf_setImageWithURL(NSURL(string: data.profileImage)!, placeholderImage: UIImage(named: "placeholder"))
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
                        
                        
                        
                    }else {
                        
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
    
    func makeTextFields(){
        
        itemTitle = TextField(frame: CGRectMake(10, self.newItemView.bounds.height + 70, self.newItemView.frame.width + 100 , 24))
        itemTitle.placeholder = "Description"
        itemTitle.font = RobotoFont.regularWithSize(20)
        itemTitle.textColor = UIColor.flatWhiteColor()
        itemTitle.titleLabel = UILabel()
        itemTitle.titleLabel!.font = RobotoFont.mediumWithSize(12)
        itemTitle.titleLabelColor = MaterialColor.grey.base
        itemTitle.titleLabelActiveColor = UIColor.flatSandColorDark()
        itemTitle.backgroundColor = UIColor.clearColor()
        itemTitle.clearButtonMode = .Always
        self.newItemView.addSubview(itemTitle)
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
        
        getImage()
        
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
    
    @IBAction func veggieBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = VEGGIES
        
        getImage()
    }
    
    @IBAction func sweetsBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = SWEETS
        
        getImage()
    }
    
    @IBAction func dairyBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = DARIY
        
        getImage()
    }
    
    @IBAction func eggsBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = EGGS
        
        getImage()
    }
    
    @IBAction func poultryBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = POULTRY
        
        getImage()
    }
    
    @IBAction func bovineBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = BOVINE
        
        getImage()
    }
    
    @IBAction func goatBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = GOAT
        
        getImage()
    }
    
    @IBAction func lambBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = LAMB
        
        getImage()
    }
    
    @IBAction func beerBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = BEER
        
        getImage()
    }
    
    
    func getImage() {
        
        let manager = PHImageManager.defaultManager()
        let initialRequestOptions = PHImageRequestOptions()
        initialRequestOptions.resizeMode = .Fast
        initialRequestOptions.deliveryMode = .HighQualityFormat
        
        let presentImagePickerController: UIImagePickerControllerSourceType -> () = { source in
            let controller = UIImagePickerController()
            controller.delegate = self
            var sourceType = source
            if (!UIImagePickerController.isSourceTypeAvailable(sourceType)) {
                sourceType = .PhotoLibrary
                print("Fallback to camera roll as a source since the simulator doesn't support taking pictures")
            }
            controller.sourceType = sourceType
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
        
        let controller = ImagePickerSheetController(mediaType: .Image)
        controller.maximumSelection = 1
        
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Take Photo", comment: "Action Title"), secondaryTitle: NSLocalizedString("Use This Image", comment: "Action Title"), handler: { _ in
            presentImagePickerController(.Camera)
            }, secondaryHandler: { action, numberOfPhotos in
                print("Comment \(numberOfPhotos) photos")
                
                let size = CGSize(width: controller.selectedImageAssets[0].pixelWidth, height: controller.selectedImageAssets[0].pixelHeight)
                
                manager.requestImageForAsset(controller.selectedImageAssets[0],
                    targetSize: size,
                    contentMode: .AspectFill,
                    options:initialRequestOptions) { (finalResult, _) in
                        
                        self.newItemImage.image = finalResult
                        self.image = finalResult
                }
                
                
        }))
        
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Photo Library", comment: "Action Title"), secondaryTitle: { NSString.localizedStringWithFormat(NSLocalizedString("ImagePickerSheet.button1.Send %lu Photo", comment: "Action Title"), $0) as String}, handler: { _ in
            presentImagePickerController(.PhotoLibrary)
            }, secondaryHandler: { _, numberOfPhotos in
                print("Comment \(numberOfPhotos) photos")
                
                let size = CGSize(width: controller.selectedImageAssets[0].pixelWidth, height: controller.selectedImageAssets[0].pixelHeight)
                
                manager.requestImageForAsset(controller.selectedImageAssets[0],
                    targetSize: size,
                    contentMode: .AspectFill,
                options:initialRequestOptions) { (finalResult, _) in
                    
                    self.newItemImage.image = finalResult
                    self.image = finalResult
                }
        }))
        
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Cancel", comment: "Action Title"), style: .Cancel, handler: { _ in
            print("Cancelled")
        }))
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            controller.modalPresentationStyle = .Popover
            controller.popoverPresentationController?.sourceView = view
            controller.popoverPresentationController?.sourceRect = CGRect(origin: view.center, size: CGSize())
        }
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        //dismissViewControllerAnimated(true, completion: nil)
       picker.dismissViewControllerAnimated(false) {
        
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        
        //dismissViewControllerAnimated(true, completion: nil)
       
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
