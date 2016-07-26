//
//  EditProfile.swift
//  Real Food
//
//  Created by Jonathan Green on 6/8/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material
import ImagePickerSheetController
import Photos
import SwiftSpinner
import PhoneNumberKit

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var firstName:TextField!
    var email:TextField!
    var address:TextField!
    var phone:TextField!
    var passWord:TextField!
    var Done:RaisedButton!
    
    var seller:Bool = false
    var image:UIImage!
    
    @IBOutlet weak var back: FlatButton!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var profileImage: FabButton!
    
    let presenter = PresentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        back.setTitle("Back", forState: .Normal)
        back.titleLabel!.font = RobotoFont.mediumWithSize(24)
        back.pulseColor = UIColor.flatSandColorDark()
        back.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
        back.hidden = true
        
        self.view.backgroundColor = UIColor.flatForestGreenColorDark()
        
        imageLabel.font = RobotoFont.regularWithSize(20)
        imageLabel.text = "Add Image"
        imageLabel.textColor = UIColor.flatSandColorDark()
        
        makeTextFields()
        makeProfileImage()
        
        makeButton("Sign Up")
        Done.addTarget(self, action: #selector(EditProfileViewController.Done(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let status = presenter.isSeller()
    
        if  status == true {
            
            phone.enabled = true
            address.enabled = true
            
        }else {
            
            phone.enabled = false
            address.enabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeProfileImage(){
        
        profileImage.backgroundColor = UIColor.flatPlumColorDark()
        profileImage.addTarget(self, action: #selector(EditProfileViewController.getImage), forControlEvents: UIControlEvents.TouchUpInside)
        profileImage.setImage(UIImage(named: "User-Add"), forState: UIControlState.Normal)
        profileImage.tintColor = UIColor.flatSandColorDark()
        profileImage.imageEdgeInsets.top = 15
        profileImage.imageEdgeInsets.bottom = 25
        profileImage.imageEdgeInsets.right = 20
        profileImage.imageEdgeInsets.left = 25
    }
    
    func makeTextFields(){
        
        firstName = TextField(frame: CGRectMake(57, self.view.frame.midY, 300, 24))
        firstName.placeholder = "UserName"
        firstName.font = RobotoFont.regularWithSize(20)
        firstName.textColor = UIColor.flatWhiteColor()
        firstName.center = self.view.center
        firstName.titleLabel = UILabel()
        firstName.center.y = self.view.center.y
        firstName.titleLabel!.font = RobotoFont.mediumWithSize(12)
        firstName.titleLabelColor = MaterialColor.grey.base
        firstName.titleLabelActiveColor = UIColor.flatSandColorDark()
        firstName.backgroundColor = UIColor.clearColor()
        firstName.clearButtonMode = .Always
        
        email = TextField(frame: CGRectMake(57, self.view.frame.midY, 300, 24))
        email.placeholder = "Email Address"
        email.font = RobotoFont.regularWithSize(20)
        email.textColor = UIColor.flatWhiteColor()
        email.center.x = self.view.center.x
        email.center.y = self.view.center.y + 50
        email.titleLabel = UILabel()
        email.titleLabel!.font = RobotoFont.mediumWithSize(12)
        email.titleLabelColor = MaterialColor.grey.base
        email.titleLabelActiveColor = UIColor.flatSandColorDark()
        email.backgroundColor = UIColor.clearColor()
        email.clearButtonMode = .Always
        
        address = TextField(frame: CGRectMake(57, self.view.frame.midY, 300, 24))
        address.placeholder = "Address"
        address.font = RobotoFont.regularWithSize(20)
        address.textColor = UIColor.flatWhiteColor()
        address.center.x = self.view.center.x
        address.center.y = self.view.center.y + 100
        address.titleLabel = UILabel()
        address.titleLabel!.font = RobotoFont.mediumWithSize(12)
        address.titleLabelColor = MaterialColor.grey.base
        address.titleLabelActiveColor = UIColor.flatSandColorDark()
        address.backgroundColor = UIColor.clearColor()
        address.clearButtonMode = .Always
        
        phone = TextField(frame: CGRectMake(57, self.view.frame.midY, 300, 24))
        phone.placeholder = "Phone Number"
        phone.font = RobotoFont.regularWithSize(20)
        phone.textColor = UIColor.flatWhiteColor()
        phone.center.x = self.view.center.x
        phone.center.y = self.view.center.y + 150
        phone.titleLabel = UILabel()
        phone.titleLabel!.font = RobotoFont.mediumWithSize(12)
        phone.titleLabelColor = MaterialColor.grey.base
        phone.titleLabelActiveColor = UIColor.flatSandColorDark()
        phone.backgroundColor = UIColor.clearColor()
        phone.clearButtonMode = .Always
        
        view.addSubview(firstName)
        view.addSubview(email)
        view.addSubview(address)
        //view.addSubview(passWord)
        view.addSubview(phone)
        
    }
    
    func makeButton(title:String){
        
        Done = RaisedButton(frame: CGRectMake(107, 207, 200, 65))
        Done.setTitle("Done", forState: .Normal)
        Done.titleLabel!.font = RobotoFont.mediumWithSize(32)
        Done.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
        Done.backgroundColor = UIColor.flatPlumColorDark()
        Done.center.x = self.view.center.x
        Done.center.y = self.view.center.y + 230
        
        self.view.addSubview(Done)
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
                    
                    self.image = finalResult
                    self.profileImage.setBackgroundImage(self.image, forState: UIControlState.Normal)
                    self.profileImage.tintColor = UIColor.clearColor()
                    self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
                    self.profileImage.layer.masksToBounds = true
                    
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
                    
                    self.image = finalResult
                    self.profileImage.setBackgroundImage(self.image, forState: UIControlState.Normal)
                    self.profileImage.tintColor = UIColor.clearColor()
                    self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
                    self.profileImage.layer.masksToBounds = true
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
            
            self.image = image
            self.profileImage.setBackgroundImage(self.image, forState: UIControlState.Normal)
            self.profileImage.tintColor = UIColor.clearColor()
            self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
            self.profileImage.layer.masksToBounds = true        }
        
    }
    
    func Done(sender: AnyObject) {
        
        guard (firstName.text != nil) else {
            
            return
        }
        
        guard (email.text != nil) else {
            
            return
        }
        
        guard (address.text != nil) else {
            
            return
        }
        
        guard (phone.text != nil) else {
            
            return
        }
        
        guard (image != nil) else {
            
            return
        }
        
        do {
            _ = try PhoneNumber(rawNumber:phone.text!)
            _ = try PhoneNumber(rawNumber: phone.text!, region: "GB")
            
            SwiftSpinner.show("Saving Changes")
            
            presenter.editUser(firstName.text!, email: email.text!, image: image, myAddress: address.text!, phone: phone.text!) { (success) in
                
                if success == true {
                    
                    SwiftSpinner.hide({
                        
                        self.performSegueWithIdentifier("Profile", sender: nil)
                    })
                    
                }else {
                    
                    SwiftSpinner.hide({
                        
                        print("Edit Failed")
                    })
                    
                }
            }
        }
        catch {
            print("Generic parser error")
        }
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
