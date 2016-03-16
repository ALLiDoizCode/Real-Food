//
//  Messages.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import UIKit
import Parse
import SwiftEventBus

class Messages {
    
    let currentUser = PFUser.currentUser()
    let roomArray:[Rooms] = []
    let messageArray:[Message] = []
    
    func sendMessage(text:String!,media:UIImage!,recipient:String!){
        
        let room = PFObject(className: "Room")
        let chat = PFObject(className: "Message")
        let userQuery = PFUser.query()
        var roomRecipient:PFUser!
    
        guard let roomQuery:PFQuery = PFQuery(className: "Room") else {
                
                do{
                    
                    try roomRecipient = userQuery?.getObjectWithId(recipient) as! PFUser
                    try roomRecipient.fetch()
                    
                }catch _{
                    
                }
            
            guard (media == nil) else {
                
                let imageData = NSData(data: UIImageJPEGRepresentation(media, 0.4)!)
                let file = PFFile(data: imageData)
                
                chat["Media"] = file
                chat["Sender"] = currentUser
                
                chat.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    let relation:PFRelation = room.relationForKey("Messages")
                    room["Sender"] = self.currentUser
                    room["Recipient"] = roomRecipient
                    relation.addObject(chat)
                    room["Status"] = true
                    
                    room.saveInBackgroundWithBlock({ (success, error) -> Void in
                        
                        print("image message sent")
                    })
                })
                
                return
            }
            
            chat["Description"] = text
            chat["Sender"] = currentUser
            
            chat.saveInBackgroundWithBlock({ (success, error) -> Void in
                
                room["Sender"] = self.currentUser
                room["Recipient"] = roomRecipient
                let relation:PFRelation = room.relationForKey("Messages")
                relation.addObject(chat)
                room["Status"] = true
                
                room.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    print("text message sent")
                })
            })
            
                return
        }
        
    }
    
    func sendMessageWithId(text:String!,media:UIImage!,roomId:String){
        
        let roomQuery:PFQuery = PFQuery(className: "Room")
        let chat = PFObject(className: "Message")
        
        roomQuery.getObjectInBackgroundWithId(roomId) { (room, error) -> Void in
            
            guard (media == nil) else {
                
                let imageData = NSData(data: UIImageJPEGRepresentation(media, 0.4)!)
                let file = PFFile(data: imageData)
                
                chat["Media"] = file
                chat["Sender"] = self.currentUser
                
                chat.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    let relation:PFRelation = room!.relationForKey("Messages")
                    relation.addObject(chat)
                    room!["Status"] = true
                    
                    room!.saveInBackgroundWithBlock({ (success, error) -> Void in
                        
                        print("image message sent")
                    })
                })
                
                return
            }
            
            chat["Description"] = text
            chat["Sender"] = self.currentUser
            
            chat.saveInBackgroundWithBlock({ (success, error) -> Void in
                
                room!["Sender"] = self.currentUser
                let relation:PFRelation = room!.relationForKey("Messages")
                relation.addObject(chat)
                room!["Status"] = true
                
                room!.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    print("text message sent")
                })
            })
            
            return
        }
        
        }

    }

