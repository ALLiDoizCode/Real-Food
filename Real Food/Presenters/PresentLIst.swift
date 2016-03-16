//
//  PresentLIst.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import UIKit
import SwiftEventBus

class PresentList {
    
    
    
    let client = Listing()
    
    func makeItem(type:String, name: String,image:UIImage,completion:(success:Bool) -> Void) {
        
        SwiftEventBus.onMainThread(self, name: "create") { notification in
            
            print("create fired")
            
            let success = notification.object as! Bool
            
            completion(success:success)
        }
        
        client.makeItem(type, name: name, image: image)
    }
    
    func getItems(type:String,completon:(data:[Item]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "getItem") { notification in
            
            print("getItem fired")
            
            let info = notification.object as! [Item]
            
            completon(data: info)
        }
        
        client.getItems(type)
    }
}