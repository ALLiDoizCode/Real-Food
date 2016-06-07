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