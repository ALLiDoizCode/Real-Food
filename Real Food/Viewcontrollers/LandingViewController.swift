//
//  LandingViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 2/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var topBorder: UILabel!
    @IBOutlet weak var bottomBorder: UILabel!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    let presenter = PresentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.attributedPlaceholder = NSAttributedString(string:"UserName",
            attributes:[NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true, alpha: 0.7)])
        passWord.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn: self.view.backgroundColor, isFlat: true, alpha: 0.7)])
        
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
        
        presenter.login(userName.text!, PassWord: passWord.text!)
        
        self.performSegueWithIdentifier("Login", sender: nil)
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
