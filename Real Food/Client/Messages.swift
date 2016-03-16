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
    var roomArray:[Rooms] = []
    let messageArray:[Message] = []
    
    func sendMessage(text:String!,media:UIImage!,recipient:String!){
        
        let room = PFObject(className: "Room")
        let chat = PFObject(className: "Message")
        let userQuery = PFUser.query()
        var roomRecipient:PFUser!
        
        do{
            
            try roomRecipient = userQuery?.getObjectWithId(recipient) as! PFUser
            try roomRecipient.fetch()
            
        }catch _{
            
        }
    
        guard let roomQuery:PFQuery = PFQuery(className: "Room") else {
            
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
                        
                        if success == true {
                            
                            print("image message sent")
                            
                        }else{
                            
                            print("image message not sent")
                        }
                        
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
                    
                    if success == true {
                        
                        print("text message sent")
                        
                    }else {
                        
                        print("text message not  sent")
                    }
                })
            })
            
                return
        }
        
        roomQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            guard let objects = objects else {
                
                return
            }
            
            for object in objects {
                
                guard let theSender = object.objectForKey("Sender") as? PFUser else {
                    
                    return
                }
                
                guard let theRecipient = object.objectForKey("Recipient") as? PFUser else {
                    
                    return
                }
                
                if (theSender == self.currentUser && theRecipient == roomRecipient) || (theSender == roomRecipient && theRecipient == self.currentUser) {
                    
                    self.sendMessageWithId(text, media: media, roomId: object.objectId!)
                }
            }
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
                        
                        if success == true {
                            
                            print("image message sent")
                        }
                        
                        print("image message not sent")
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
                    
                    if success == true {
                        
                        print("text message sent")
                        
                    }else {
                        
                        print("text message not  sent")
                    }
                })
            })
        }
        
        }
    
    func getRooms(){
        
        let roomQuery:PFQuery = PFQuery(className: "Room")
        
        roomQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            guard let objects = objects else {
                
                print("no objects")
                
                return
            }
            
            for object in objects {
                
                guard let theSender = object.objectForKey("Sender") as? PFUser else {
                    
                    print("no sender")
                    
                    return
                }
                
                guard let theRecipient = object.objectForKey("Recipient") as? PFUser else {
                    
                    print("no Recipient")
                    
                    return
                }
                
                guard let theStatus = object.objectForKey("Status") as? Bool else {
                    
                    print("no status")
                    
                    return
                }
                
                guard let icon:PFFile = theSender.objectForKey("ProfileImage") as? PFFile else {
                    
                    print("no icon")
                    
                    return
                }
                
                if theSender == self.currentUser || theRecipient == self.currentUser {
                    
                    let theRoom = Rooms(theObjectId: object.objectId!, theRecipiant: theRecipient.objectId!, theCreatedBy: theSender.objectId!, theStatus: theStatus, theTime: object.updatedAt!,theIcon: icon.url!)
                    
                    self.roomArray.append(theRoom)
                    
                    SwiftEventBus.post("Rooms", sender: self.roomArray)
                }
            }
        }
    }

}

