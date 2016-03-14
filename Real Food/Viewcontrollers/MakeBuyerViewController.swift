//
//  MakeBuyerViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 3/13/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material

class MakeBuyerViewController: UIViewController {
    
    var firstName:TextField!
    var email:TextField!
    var passWord:TextField!
    var signUp:RaisedButton!
    
    var seller:Bool = false

    @IBOutlet weak var back: FlatButton!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var profileImage: FabButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        back.setTitle("Back", forState: .Normal)
        back.titleLabel!.font = RobotoFont.mediumWithSize(24)
        back.pulseColor = UIColor.flatSandColorDark()
        back.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
        
        self.view.backgroundColor = UIColor.flatForestGreenColorDark()
        
        imageLabel.font = RobotoFont.regularWithSize(20)
        imageLabel.text = "Add Image"
        imageLabel.textColor = UIColor.flatSandColorDark()
        
        makeTextFields()
        makeProfileImage()
        
        if seller == true {
            
            makeButton("Continue")
            signUp.addTarget(self, action: "continueBtn:", forControlEvents: UIControlEvents.TouchUpInside)
            
        }else {
            
            makeButton("Sign Up")
            signUp.addTarget(self, action: "signUpBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeProfileImage(){
        
        profileImage.backgroundColor = UIColor.flatPlumColorDark()
        profileImage.setImage(UIImage(named: "User-Add"), forState: UIControlState.Normal)
        profileImage.tintColor = UIColor.flatSandColorDark()
        profileImage.imageEdgeInsets.top = 15
        profileImage.imageEdgeInsets.bottom = 25
        profileImage.imageEdgeInsets.right = 20
        profileImage.imageEdgeInsets.left = 25
    }
    
    func makeTextFields(){
        
        firstName = TextField(frame: CGRectMake(57, self.view.frame.midY, 300, 24))
        firstName.placeholder = "First Name"
        firstName.font = RobotoFont.regularWithSize(20)
        firstName.textColor = UIColor.flatWhiteColor()
        firstName.center = self.view.center
        firstName.titleLabel = UILabel()
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
        
        view.addSubview(firstName)
        view.addSubview(email)
        view.addSubview(passWord)
        
       
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
   
    func signUpBtn(sender: AnyObject) {
        
    }
    
    func continueBtn(sender: AnyObject){
        
        self.performSegueWithIdentifier("card", sender: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
