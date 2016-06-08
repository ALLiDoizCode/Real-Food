//
//  Cloud.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import Parse

class Cloud {
    
    func NewMessage(Recipient:String){
        
        PFCloud.callFunctionInBackground("Message", withParameters: ["Recipient":Recipient]) {
            (response: AnyObject?, error: NSError?) -> Void in
            //let responseString = response as? String
            
            
            if error == nil  {
                
                print("cloud fired")
            }
        }
    }
}