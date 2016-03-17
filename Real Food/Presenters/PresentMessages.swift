//
//  PresentMessages.swift
//  Real Food
//
//  Created by Jonathan Green on 3/16/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import UIKit
import SwiftEventBus

class PresentMessages {
    
    let client = Messages()
    
    func getRooms(completion:(data:[Rooms]) -> Void){
        
        print("fired room presenter")
        
        SwiftEventBus.onMainThread(self, name: "Rooms") { (notifiaction) -> Void in
            
            print("fired room event")
            
            let info = notifiaction.object as! [Rooms]
            
            completion(data: info)
        }
        
        client.getRooms()
    }
    
    func sendMessage(text:String,recipient:String,completion:(success:Bool) -> Void){
        
         print("fired function")
        
        SwiftEventBus.onMainThread(self, name: "SendMessage") { (notification) -> Void in
            
            print("fired event")
            
            let info = notification.object as! Bool
            
            completion(success: info)
        }
        
        client.sendMessage(text, recipient: recipient)
    }
    
    func sendImage(media:UIImage!,recipient:String,completion:(success:Bool) -> Void){
        
         print("fired function")
        
        SwiftEventBus.onMainThread(self, name: "SendMessage") { (notification) -> Void in
            
             print("fired event")
            
            let info = notification.object as! Bool
            
            completion(success: info)
        }
        
        client.sendImage(media, recipient: recipient)
    }
}