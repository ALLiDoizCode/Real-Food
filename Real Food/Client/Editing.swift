//
//  Editing.swift
//  Real Food
//
//  Created by Jonathan Green on 6/6/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import Parse
import SwiftEventBus

class Editing {
    
    let currentUser = PFUser.currentUser()
    
    let location = Location()
    
    func editUser(userName:String,email:String,image:UIImage,myAddress:String,phone:String){
        
        let imageData = NSData(data: UIImageJPEGRepresentation(image, 0.4)!)
        let file = PFFile(data: imageData)
        
        currentUser!.username = userName
        currentUser!.email = email
        currentUser!["ProfileImage"] = file
        currentUser!["Phone"] = phone
        
        location.reverseAddress(myAddress) { (lat, long) -> Void in
            
            let geoPoint = PFGeoPoint(latitude:lat, longitude:long)
            
            self.currentUser!["Location"] = geoPoint
            
            self.currentUser!.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                
            }
        }
        
        currentUser?.saveInBackgroundWithBlock({ (success, error) in
            
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                
                print(error.description)
                
                 SwiftEventBus.post("Edit", sender: success)
                
            } else {
                
                // Hooray! Let them use the app now.
                
                 SwiftEventBus.post("Edit", sender: success)
                
                print("User Edited")
            }
        })
    }
    
    func delteObject(type:String,itemId:String) {
        
        let object = PFQuery(className: type)
        
        object.getObjectInBackgroundWithId(itemId) { (object, error) in
            
            if let object = object {
                
                object.deleteInBackgroundWithBlock({ (success, error) in
                    
                    print("deletion successfull")
                    
                    SwiftEventBus.post("Delete Item", sender: true)
                })
                
            }else {
                
                print("no object found for deletion")
                SwiftEventBus.post("Delete Item", sender: false)
            }
        }
    }
    
}