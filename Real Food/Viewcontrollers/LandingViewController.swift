//
//  LandingViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 2/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Cartography
import Material

class LandingViewController: UIViewController {

    
    @IBOutlet weak var topBorder: UILabel!
    @IBOutlet weak var bottomBorder: UILabel!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var logo: UIImageView!
    var loginTitle: MaterialLabel!
    
    let presenter = PresentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo = UIImageView()
        logo.image = UIImage(named: "GreenPepper2")
        logo.contentMode = .ScaleAspectFill
        
        loginTitle = MaterialLabel()
        loginTitle.text = "Green Peppers"
        loginTitle.font = RobotoFont.boldWithSize(40)
        loginTitle.textColor = UIColor.flatSandColor()
        loginTitle.textAlignment = .Center
        self.view.addSubview(logo)
        self.view.addSubview(loginTitle)
        
        constrain(logo,loginTitle) { (logo,loginTitle) in
            
            loginTitle.width == (loginTitle.superview?.width)!
            loginTitle.height == 50
            loginTitle.centerX == (loginTitle.superview?.centerX)!
            loginTitle.top == (loginTitle.superview?.top)! + 20
            
            logo.width == (logo.superview?.width)! * 0.3
            logo.height == logo.width + 20
            logo.top == loginTitle.bottom + 20
            logo.centerX == (logo.superview?.centerX)!
            
        }
        
        userName.attributedPlaceholder = NSAttributedString(string:"UserName",
            attributes:[NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true, alpha: 0.7)])
        passWord.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true, alpha: 0.7)])
        passWord.secureTextEntry = true
        
        loginBtn.backgroundColor = UIColor(complementaryFlatColorOf: self.view.backgroundColor)
        loginBtn.setTitleColor(UIColor.flatSandColor(), forState: UIControlState.Normal)
        loginBtn.layer.cornerRadius = 4
        
        //signUpBtn.backgroundColor = UIColor(complementaryFlatColorOf: self.view.backgroundColor)
        //signUpBtn.setTitleColor(UIColor.flatSandColor(), forState: UIControlState.Normal)
        loginBtn.layer.cornerRadius = 4
        
        loginBtn.layer.masksToBounds = true
        signUpBtn.layer.masksToBounds = true
        
        
        topBorder.frame = CGRectMake(topBorder.layer.frame.origin.x, topBorder.layer.frame.origin.y
            , topBorder.layer.frame.width, 0.5)
        
        bottomBorder.frame = CGRectMake(bottomBorder.layer.frame.origin.x, bottomBorder.layer.frame.origin.y
            , bottomBorder.layer.frame.width, 0.5)
        
        
        topBorder.layer.masksToBounds = true
        bottomBorder.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true
    }

    @IBAction func loginBtn(sender: AnyObject) {
        
        guard (userName.text != nil) else {
            
            return
        }
        
        guard (passWord.text != nil) else {
            
            return
        }
        
        SwiftEventBus.onMainThread(self, name: "Login Result") { (result) in
            
            print("Login Fired")
            
            let success = result.object as! Bool
            
            if success == true {
                
                self.performSegueWithIdentifier("Login", sender: nil)
                
            }else {
                
                print("login failed")
                
                SweetAlert().showAlert("Failed!", subTitle: "username or password is incorrect", style: AlertStyle.Error)
            }
            
            SwiftEventBus.unregister(self, name: "Login Result")
        }
        
        presenter.login(userName.text!, PassWord: passWord.text!)
        
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
