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
            
            SwiftEventBus.unregister(self, name: "create")
        }
        
        client.makeItem(type, name: name, image: image)
    }
    
    func getItems(type:String,miles:Double,completon:(data:[Item]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "getItem") { notification in
            
            print("getItem fired")
            
            let info = notification.object as! [Item]
            
            completon(data: info)
            
            SwiftEventBus.unregister(self, name: "getItem")
        }
        
        client.getItems(type,miles:miles)
    }
    
    func getMyItems(completon:(data:[Item]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "myItems") { notification in
            
            print("getMyItems fired")
            
            let info = notification.object as! [Item]
            
            completon(data: info)
            
            SwiftEventBus.unregister(self, name: "myItems")
        }
        
        client.getMyItems()
    }
}