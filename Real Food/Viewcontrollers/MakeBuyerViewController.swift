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

    @IBOutlet weak var profileImage: FabButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.flatForestGreenColorDark()
       
        
        makeTextFields()
        makeProfileImage()
        
        
        
        

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
