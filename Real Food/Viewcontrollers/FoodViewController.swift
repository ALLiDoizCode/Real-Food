//
//  FoodViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 1/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import ChameleonFramework
import BTNavigationDropdownMenu
import Kingfisher
import Material
import Cartography
import ImagePickerSheetController
import Photos
import SwiftSpinner
import FXBlurView
import SwiftEventBus

class FoodViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let menu = getMenu.sharedInstance
    let presenter = PresentList()
    let presenterUser = PresentUser()
    let profileViews = ProfileViews()
    let getImage = GetImage()
    
    var home:TextField!
    var phone:TextField!
    var done:FlatButton!
    
    let controller = UIImagePickerController()
    
    var type:String!
    var image:UIImage!
    var miles:Double!
    
    let cellIdentefier = "Food"
    
    @IBOutlet weak var cover: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var newItemView: UIView!
    @IBOutlet weak var newItemImage: UIImageView!
    
    var cancle: FabButton!
    var camera: FabButton!
    var addItem: FabButton!
    
    
    @IBOutlet weak var addButton: FabButton!
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
    
    var menuView: BTNavigationDropdownMenu!
    
    var itemArray:[Item] = []
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.delegate = self
        
        itemTitle = TextField(frame: CGRectMake(10, self.newItemView.bounds.height + 70, self.newItemView.frame.width + 100 , 24))
        
        newItemView.hidden = true
        
        cancle = FabButton()
        camera = FabButton()
        addItem = FabButton()
        
        newItemView.addSubview(cancle)
        newItemView.addSubview(camera)
        newItemView.addSubview(addItem)
        
        profileViews.makeButton(veggie, sweets: sweets, dariy: dariy, eggs: eggs, poultry: poultry, bovine: bovine, goat: goat, lamb: lamb, beer: beer, addButton: addButton, camera: camera, addItem: addItem, cancle: cancle, controller: self) { (veggie, sweets, dariy, eggs, poultry, bovine, goat, lamb, beer, addButton, camera, addItem, cancle) in
            
            
            camera.addTarget(self, action: #selector(FoodViewController.cameraBtn), forControlEvents: UIControlEvents.TouchUpInside)
            addItem.addTarget(self, action: #selector(FoodViewController.addItemBtn), forControlEvents: UIControlEvents.TouchUpInside)
            cancle.addTarget(self, action: #selector(FoodViewController.cancelBtn), forControlEvents: UIControlEvents.TouchUpInside)
            
            constrain(camera,addItem,cancle) { (camera,addItem,cancle) in
                
                camera.bottom == (camera.superview?.bottom)! - 10
                camera.centerX == (camera.superview?.centerX)!
                camera.height == 50
                camera.width == camera.height
                
                addItem.bottom == (addItem.superview?.bottom)! - 10
                addItem.left == (addItem.superview?.left)! + 10
                addItem.height == 50
                addItem.width == camera.height
                
                cancle.bottom == (cancle.superview?.bottom)! - 10
                cancle.right == (cancle.superview?.right)! - 10
                cancle.height == 50
                cancle.width == camera.height
                
            }
        }
        
        profileViews.makeTextFields(itemTitle, controller: self)
        
        miles = 50
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(FoodViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.TableView.addSubview(self.refreshControl) // not required when using UITableViewController
        
        
        
        print(type)
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        buttonView.hidden = true
        cover.hidden = true
        
        menu.setupMenu(self,title:type)
        
        presenter.getItems(type,miles:miles) { (data) -> Void in
            
            print(self.type)
            
            self.itemArray.removeAll()
            
            self.itemArray = data
            
            self.reload()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        menu.menuView.hide()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(sender:AnyObject) {
        // Code to refresh table view
        presenter.getItems(type,miles:miles) { (data) -> Void in
            
            print(self.type)
            
            self.itemArray.removeAll()
            
            self.itemArray = data
            
            self.refreshControl.endRefreshing()
            
            self.reload()
        }
    }
    
    func reload(){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.TableView.reloadData()
        });
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:FoodCell = tableView.dequeueReusableCellWithIdentifier(cellIdentefier) as! FoodCell
        
         //cell.contentView.backgroundColor = UIColor(contrastingBlackOrWhiteColorOn: self.navigationController?.navigationBar.barTintColor, isFlat: true)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            print(self.itemArray[indexPath.row].image)
            
            cell.cellImage.kf_setImageWithURL(NSURL(string: self.itemArray[indexPath.row].image)!, placeholderImage: UIImage(named:"placeholder"))
            cell.userIcon.kf_setImageWithURL(NSURL(string: self.itemArray[indexPath.row].profileImage)!, placeholderImage: UIImage(named: "placeholder"))
            cell.mainLabel.text = self.itemArray[indexPath.row].userName
            cell.foodDescription.text = self.itemArray[indexPath.row].description
            cell.distance.text = self.itemArray[indexPath.row].distance
            
            print("cell \(self.itemArray[indexPath.row].userName)")
            
            let imageColor = UIColor(averageColorFromImage:cell.cellImage.image)
            
            cell.layoutSubviews()
        });
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 250
    }
    
   func addItemBtn() {
        
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
                
                self.presenter.getItems(self.type,miles:self.miles) { (data) -> Void in
                    
                    print(self.type)
                    
                    self.itemArray.removeAll()
                    
                    self.itemArray = data
                    
                    self.reload()
                    
                    SwiftSpinner.hide({ 
                        
                        print("alert user that item saved")
                    })
                }
                
                
            }else {
                
                SwiftSpinner.hide({
                    
                    print("There was an issue saving your item")
                })
                
            }
        }
        
    }
    
    func cameraBtn() {
        
        getImage.getImage(self, theController: controller) { (image) in
            
            self.newItemImage.image = image
            self.image = image
        }
        
    }
    
   func cancelBtn() {
        
        newItemView.hidden = true
        cover.hidden = true
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
    
    @IBAction func add(sender: AnyObject) {
        
        /// check to see if seller
        
        SwiftEventBus.onMainThread(self, name: "New Seller") { (result) in
            
            let success = result.object as! Bool
            
            if success == true {
                
                self.buttonView.hidden = false
                self.cover.hidden = false
            }
        }
        
        if presenterUser.isSeller() == true {
            
            buttonView.hidden = false
            cover.hidden = false
            
        }else {
            
            home = TextField()
            phone = TextField()
            done = FlatButton()
            done.addTarget(self, action: #selector(FoodViewController.doneBtn), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.view.addSubview(home)
            self.view.addSubview(phone)
            self.view.addSubview(done)
            
            profileViews.makeSeller(home, phone: phone,button:done)
            
        }
        
    }
    
    
    func doneBtn() {
        
        if phone.text != "" && home.text != "" {
            
            presenterUser.makeSeller(phone.text!, address: home.text!)
            
        }else {
            
            //need to fill in all text fields
        }
        
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let indexPath = self.TableView.indexPathForSelectedRow
        
        if segue.identifier == "seller" {
            
            let controller = segue.destinationViewController as! SellerViewController
            
            print("user id \(self.itemArray[indexPath!.row].objectId)")
            
            controller.sellerId = self.itemArray[indexPath!.row].objectId
            controller.sellerIcon = self.itemArray[indexPath!.row].profileImage
            controller.sellerName = self.itemArray[indexPath!.row].userName
            controller.itemIcon = self.itemArray[indexPath!.row].image
            controller.sellerDistance = self.itemArray[indexPath!.row].distance
        }
    }
    
}
