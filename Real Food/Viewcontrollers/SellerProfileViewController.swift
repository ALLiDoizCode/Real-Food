//
//  SellerProfileViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 2/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import FXBlurView
import Material

class SellerProfileViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.bgImage.clipsToBounds = true
        
          dispatch_async(dispatch_get_main_queue(), {
            
            let blurredImage = self.bgImage.image?.blurredImageWithRadius(20, iterations: 2, tintColor: UIColor.clearColor())
            
            self.bgImage.image = blurredImage
           
            
            self.userImage.layer.cornerRadius = self.userImage.layer.frame.height/2
            self.userImage.layer.borderColor = UIColor.flatSandColorDark().CGColor
            self.userImage.layer.borderWidth = 3
            
            self.userName.font = RobotoFont.mediumWithSize(14)
            self.userName.text = "Sara"
            
            self.userImage.layer.masksToBounds = true
            self.userImage.clipsToBounds = true
            
        });
        
       
        
        

        // Do any additional setup after loading the view.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
