//
//  ChatRoomViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import ImagePickerSheetController
import Photos
import Parse

class ChatRoomViewController: JSQMessagesViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var userIcon:UIImage!
    var sellerId:String!
    var roomId:String!
    var selectedImage:UIImage!
    
    let currentUser = PFUser.currentUser()
    
    let menu = getMenu.sharedInstance
    let presenter = PresentMessages()
    
    var messages:[JSQMessage] = [JSQMessage]()
    
    var avatar:JSQMessagesAvatarImage!
    var outgoingBubbleImageData = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.grayColor())
    var incomingBubbleImageData = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.blueColor())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
          menu.setupMenu(self,title:"Messages")
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
                        
                        let photo = JSQPhotoMediaItem(image:finalResult)
                        
                        let messageMedia = JSQMessage(senderId: self.senderId, displayName: self.senderDisplayName, media: photo)
                        
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
    
    
    func setup() {
        self.senderId = currentUser?.objectId
        self.senderDisplayName = UIDevice.currentDevice().identifierForVendor?.UUIDString
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}




//MARK - Data Source
extension ChatRoomViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        let data = self.messages[indexPath.row]
        return data
    }
    
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
        self.messages.removeAtIndex(indexPath.row)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let data = messages[indexPath.row]
        switch(data.senderId) {
        case self.senderId:
            return self.outgoingBubbleImageData
        default:
            return self.incomingBubbleImageData
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        let diameter = UInt(kJSQMessagesCollectionViewAvatarSizeDefault)
        let avatarImage = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "placeholder"), diameter: diameter)
        
        let avatarImage2 = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "placeholder"), diameter: diameter)
        
        let data = messages[indexPath.row]
        switch(data.senderId) {
        case self.senderId:
            return avatarImage
        default:
            return avatarImage2
        }
        
    }
    
}



//MARK - Toolbar
extension ChatRoomViewController {
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        //let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        
        if selectedImage == nil {
            
            if self.roomId == nil {
                
                presenter.sendMessage(text, recipient:sellerId) { (success) -> Void in
                    
                    print("fired presenter")
                    
                    if success == true {
                        
                        print("message sent")
                        
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
        }
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        
        print("didPressAccessoryButton")
        
        getImage()
    }
}

