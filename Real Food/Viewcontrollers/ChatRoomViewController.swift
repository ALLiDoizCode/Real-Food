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
    var userIcon:UIImage!
    var sellerId:String!
    var roomId:String!
    var selectedImage:UIImage!
    
    let currentUser = PFUser.currentUser()
    
    let menu = getMenu.sharedInstance
    let presenter = PresentMessages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 246.0
        
        //self.tableView.bubbleDataSource = self
        
        /*self.tableView.someoneElse_grouping = false // default is true
        self.tableView.header_scrollable = true // defaut is true. false is not implement yet.
        self.tableView.header_show_weekday = true // default is true
        
        self.tableView.refreshable = true // default is false
        self.tableView.show_nickname = true // default is false*/
        
        /*if selectedImage == nil {
            
            if self.roomId == nil {
                
                presenter.sendMessage(text, recipient:sellerId) { (success) -> Void in
                    
                    print("fired presenter")
                    
                    if success == true {
                        
                        print("message sent")
                        
                        self.finishSendingMessage()
                        
                    }else{
                        
                        print("message not sent")
                        
                    }
                }
                
            }else{
                
                presenter.sendMessageWithId(text, roomId: roomId, completion: { (success) -> Void in
                    
                    if success == true {
                        
                        print("message sent")
                    }
                })
            }
            
            
        }else {
            
            presenter.sendImage(selectedImage, recipient: sellerId, completion: { (success) -> Void in
                
                print("fired presenter")
                
                if success == true {
                    
                    print("image sent")
                    
                    
                    
                }else{
                    
                    print("iamge not sent")
                }
            })
        }*/
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
          menu.setupMenu(self,title:"Messages")
        
       /* presenter.getMessages(roomId) { (data) -> Void in
            
        }*/
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        menu.menuView.hide()
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
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("chat") as! ChatCell
        
        cell.icon1.image = UIImage(named: "girl")
        cell.time1.text = "20ms"
        cell.message.text = "dfnashasdfnashasasdhakhjdjhasdjakldjaldfnashasasdhakhjdjhasdjakldjaldfnashasasdhakhjdjhasdjakldjaldfnashasasdhakhjdjhasdjakldjalasdhakhjdjhasdjakldjal"
        
        return cell
    }

}






