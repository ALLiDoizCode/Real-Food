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
import Kingfisher

class PresentMessages {
    
    let client = Messages()
    
    func getMessages(roomId:String!,completion:(data:[Message]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "getMessages") { (notification) -> Void in
            
            let objects = notification.object as! [Message]
            
            completion(data: objects)
        }
        
        client.getMessage(roomId)
    }
    
    func getRooms(completion:(data:[Rooms]) -> Void){
        
        print("fired room presenter")
        
        SwiftEventBus.onMainThread(self, name: "getRooms") { (notifiaction) -> Void in
            
            print("fired room event")
            
            let info = notifiaction.object as! [Rooms]
            
            completion(data: info)
            
            SwiftEventBus.unregister(self, name: "getRooms")
        }
        
            client.getRooms()
    }
    
    func sendMessage(text:String,recipient:String,completion:(success:Bool) -> Void){
        
        print("fired function")
        
        SwiftEventBus.onMainThread(self, name: "sendMessage") { (notification) -> Void in
            
            print("fired event")
            
            let info = notification.object as! Bool
            
            completion(success: info)
            
            SwiftEventBus.unregister(self, name: "messageWithId")
        }
        
        client.sendMessage(recipient, text: text)
    }
    
}