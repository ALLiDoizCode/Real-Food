//
//  ChatRoomViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import ImagePickerSheetController
import Photos
import Parse


class ChatRoomViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var textField: UITextField!
    var userIcon:UIImage!
    var sellerId:String!
    var roomId:String!
    var selectedImage:UIImage!
    
    let currentUser = PFUser.currentUser()
    
    let menu = getMenu.sharedInstance
    let presenter = PresentMessages()
    
    var messageArray:[Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 246.0
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
          menu.setupMenu(self,title:"Messages")
        
       presenter.getMessages(roomId) { (data) -> Void in
        
            self.messageArray.removeAll()
            self.messageArray = data
            self.reload()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        menu.menuView.hide()
    }
    
    @IBAction func sendBtn(sender: AnyObject) {
        
        if textField.text != "" {
            
            presenter.sendMessage(textField.text!, recipient: sellerId, completion: { (success) -> Void in
                
                if success == true {
                    
                    self.presenter.getMessages(self.roomId) { (data) -> Void in
                        
                        self.messageArray.removeAll()
                        self.messageArray = data
                        self.reload()
                    }
                    
                }else {
                    
                    
                }
            })
        }
    }
    func reload(){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.tableView.reloadData()
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // func that fires when assecory button is clicked
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
                        
                        self.selectedImage = finalResult
                        print(finalResult)
                        
                        // fire presenter to send image
                        
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
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.messageArray.capacity
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("chat") as! ChatCell
        let cell2 = tableView.dequeueReusableCellWithIdentifier("chat2") as! ChatCell2
        
        if messageArray[indexPath.row].sender != currentUser?.objectId {
            
           
            dispatch_async(dispatch_get_main_queue(), {
                
                cell2.icon.kf_setImageWithURL(NSURL(string: self.messageArray[indexPath.row].senderImage)!, placeholderImage: UIImage(named: "placeholder"))
                cell2.name.text = self.messageArray[indexPath.row].senderName
                let date = self.messageArray[indexPath.row].time
                let time = NSDate().offsetFrom(date)
                cell2.time.text = time
                cell2.message.text = self.messageArray[indexPath.row].description
            
            });
            
            return cell2
            
        }else {
            
            
            
            dispatch_async(dispatch_get_main_queue(), {
                
                cell.icon.kf_setImageWithURL(NSURL(string: self.messageArray[indexPath.row].senderImage)!, placeholderImage: UIImage(named: "placeholder"))
                cell.name.text = self.messageArray[indexPath.row].senderName
                let date = self.messageArray[indexPath.row].time
                let time = NSDate().offsetFrom(date)
                cell.time.text = time
                cell.message.text = self.messageArray[indexPath.row].description
                
            });
            
             return cell
        }
        
       
    }

}






