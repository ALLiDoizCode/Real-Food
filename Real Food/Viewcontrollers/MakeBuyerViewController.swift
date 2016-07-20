//
//  MakeBuyerViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 3/13/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material
import ImagePickerSheetController
import Photos
import SwiftSpinner
import PhoneNumberKit

class MakeBuyerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var firstName:TextField!
    var email:TextField!
    var passWord2:TextField!
    var passWord:TextField!
    var signUp:RaisedButton!
    
    var seller:Bool = false
    var image:UIImage!

    @IBOutlet weak var back: FlatButton!
    //@IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var profileImage: FabButton!
    
    let presenter = PresentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        back.setTitle("Back", forState: .Normal)
        back.titleLabel!.font = RobotoFont.mediumWithSize(24)
        back.pulseColor = UIColor.flatSandColorDark()
        back.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
        
        self.view.backgroundColor = UIColor.flatForestGreenColorDark()
        
        //imageLabel.font = RobotoFont.regularWithSize(20)
        //imageLabel.text = "Add Image"
        //imageLabel.textColor = UIColor.flatSandColorDark()
        
        makeTextFields()
        makeProfileImage()
        
        if seller == true {
            
            makeButton("Continue")
            signUp.addTarget(self, action: #selector(MakeBuyerViewController.continueBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
        }else {
            
            makeButton("Sign Up")
            signUp.addTarget(self, action: #selector(MakeBuyerViewController.signUpBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeProfileImage(){
        
        profileImage.backgroundColor = UIColor.flatPlumColorDark()
        profileImage.addTarget(self, action: #selector(MakeBuyerViewController.getImage), forControlEvents: UIControlEvents.TouchUpInside)
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
        firstName.center.y = self.view.center.y - 50
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
        email.center.y = self.view.center.y
        email.titleLabel = UILabel()
        email.titleLabel!.font = RobotoFont.mediumWithSize(12)
        email.titleLabelColor = MaterialColor.grey.base
        email.titleLabelActiveColor = UIColor.flatSandColorDark()
        email.backgroundColor = UIColor.clearColor()
        email.clearButtonMode = .Always
        
        passWord2 = TextField(frame: CGRectMake(57, self.view.frame.midY, 300, 24))
        passWord2.placeholder = "Password"
        passWord2.font = RobotoFont.regularWithSize(20)
        passWord2.textColor = UIColor.flatWhiteColor()
        passWord2.center.x = self.view.center.x
        passWord2.center.y = self.view.center.y + 50
        passWord2.titleLabel = UILabel()
        passWord2.titleLabel!.font = RobotoFont.mediumWithSize(12)
        passWord2.titleLabelColor = MaterialColor.grey.base
        passWord2.titleLabelActiveColor = UIColor.flatSandColorDark()
        passWord2.backgroundColor = UIColor.clearColor()
        passWord2.clearButtonMode = .Always
        passWord2.secureTextEntry = true
        
        passWord = TextField(frame: CGRectMake(57, self.view.frame.midY, 300, 24))
        passWord.placeholder = "Password"
        passWord.font = RobotoFont.regularWithSize(20)
        passWord.textColor = UIColor.flatWhiteColor()
        passWord.center.x = self.view.center.x
        passWord.center.y = self.view.center.y + 100
        passWord.titleLabel = UILabel()
        passWord.titleLabel!.font = RobotoFont.mediumWithSize(12)
        passWord.titleLabelColor = MaterialColor.grey.base
        passWord.titleLabelActiveColor = UIColor.flatSandColorDark()
        passWord.backgroundColor = UIColor.clearColor()
        passWord.clearButtonMode = .Always
        passWord.secureTextEntry = true
        
        view.addSubview(firstName)
        view.addSubview(email)
        view.addSubview(passWord)
        view.addSubview(passWord2)
       
    }
    
    func makeButton(title:String){
        
        signUp = RaisedButton(frame: CGRectMake(107, 207, 200, 65))
        signUp.setTitle(title, forState: .Normal)
        signUp.titleLabel!.font = RobotoFont.mediumWithSize(32)
        signUp.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
        signUp.backgroundColor = UIColor.flatPlumColorDark()
        signUp.center.x = self.view.center.x
        signUp.center.y = self.view.center.y + 200
        
        self.view.addSubview(signUp)
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

       func signUpBtn(sender: AnyObject) {
        
        guard (firstName.text != nil) else {
            
            return
        }
        
        guard (email.text != nil) else {
            
            return
        }
        
        guard (passWord2.text != nil) else {
            
            return
        }
        
        guard (passWord.text != nil) else {
            
            return
        }
        
        guard (passWord.text == passWord2.text) else {
            
            return
        }
        
        guard (image != nil) else {
            
            return
        }
        
        SwiftSpinner.show("Creating Account")
        
        presenter.makeUser(firstName.text!, passWord: passWord.text!, email: email.text!, image: image) { (success) -> Void in
            
            if success == true {
                
                SwiftSpinner.hide({
                    
                    self.performSegueWithIdentifier("Main", sender: nil)
                })
                
            }else {
                
                SwiftSpinner.hide({
                    
                    print("Signup Failed")
                })
                
            }
        }
        
        /*do {
            _ = try PhoneNumber(rawNumber:phone.text!)
            _ = try PhoneNumber(rawNumber: phone.text!, region: "GB")
            
            
        }
        catch {
            
            print("Generic parser error")
        }*/
        
    }
    
    func continueBtn(sender: AnyObject){
        
        self.performSegueWithIdentifier("card", sender: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
