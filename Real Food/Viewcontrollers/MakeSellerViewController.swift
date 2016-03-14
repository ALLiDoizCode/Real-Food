//
//  MakeSellerViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 3/13/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material

class MakeSellerViewController: UIViewController {
    
    var nameOnCard:TextField!
    var cardNumber:TextField!
    var cvc:TextField!
    var signUp:RaisedButton!

    @IBOutlet weak var back: FlatButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        back.setTitle("Back", forState: .Normal)
        back.titleLabel!.font = RobotoFont.mediumWithSize(24)
        back.pulseColor = UIColor.flatSandColorDark()
        back.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
        
        self.view.backgroundColor = UIColor.flatForestGreenColorDark()
        makeTextFields()
        
        makeButton()
        signUp.addTarget(self, action: "signUpBtn:", forControlEvents: UIControlEvents.TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeTextFields(){
        
        nameOnCard = TextField(frame: CGRectMake(57, self.view.frame.midY, 300, 24))
        nameOnCard.placeholder = "Name On Card"
        nameOnCard.font = RobotoFont.regularWithSize(20)
        nameOnCard.textColor = UIColor.flatWhiteColor()
        nameOnCard.center = self.view.center
        nameOnCard.titleLabel = UILabel()
        nameOnCard.titleLabel!.font = RobotoFont.mediumWithSize(12)
        nameOnCard.titleLabelColor = MaterialColor.grey.base
        nameOnCard.titleLabelActiveColor = UIColor.flatSandColorDark()
        nameOnCard.backgroundColor = UIColor.clearColor()
        nameOnCard.clearButtonMode = .Always
        
        cardNumber = TextField(frame: CGRectMake(57, self.view.frame.midY, 300, 24))
        cardNumber.placeholder = "Card Number"
        cardNumber.font = RobotoFont.regularWithSize(20)
        cardNumber.textColor = UIColor.flatWhiteColor()
        cardNumber.center.x = self.view.center.x
        cardNumber.center.y = self.view.center.y + 50
        cardNumber.titleLabel = UILabel()
        cardNumber.titleLabel!.font = RobotoFont.mediumWithSize(12)
        cardNumber.titleLabelColor = MaterialColor.grey.base
        cardNumber.titleLabelActiveColor = UIColor.flatSandColorDark()
        cardNumber.backgroundColor = UIColor.clearColor()
        cardNumber.clearButtonMode = .Always
        
        cvc = TextField(frame: CGRectMake(57, self.view.frame.midY, 300, 24))
        cvc.placeholder = "CVC"
        cvc.font = RobotoFont.regularWithSize(20)
        cvc.textColor = UIColor.flatWhiteColor()
        cvc.center.x = self.view.center.x
        cvc.center.y = self.view.center.y + 100
        cvc.titleLabel = UILabel()
        cvc.titleLabel!.font = RobotoFont.mediumWithSize(12)
        cvc.titleLabelColor = MaterialColor.grey.base
        cvc.titleLabelActiveColor = UIColor.flatSandColorDark()
        cvc.backgroundColor = UIColor.clearColor()
        cvc.clearButtonMode = .Always
        
        view.addSubview(nameOnCard)
        view.addSubview(cardNumber)
        view.addSubview(cvc)
        
    }
    
    func makeButton(){
        
        signUp = RaisedButton(frame: CGRectMake(107, 207, 200, 65))
        signUp.setTitle("Sign Up", forState: .Normal)
        signUp.titleLabel!.font = RobotoFont.mediumWithSize(32)
        signUp.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
        signUp.backgroundColor = UIColor.flatPlumColorDark()
        signUp.center.x = self.view.center.x
        signUp.center.y = self.view.center.y + 200
        
        self.view.addSubview(signUp)
    }
    
    func signUpBtn(sender: AnyObject) {
        
        self.performSegueWithIdentifier("Main", sender: nil)
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
