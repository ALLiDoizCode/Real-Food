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
    var messageArray:[Message] = []
    
    func sendMessage(text:String!,recipient:String!){
        
        print("send message start")
        
        let room = PFObject(className: "Room")
        let chat = PFObject(className: "Message")
        let userQuery = PFUser.query()
        var roomRecipient:PFUser!
        
        do{
            
            try roomRecipient = userQuery?.getObjectWithId(recipient) as! PFUser
            try roomRecipient.fetch()
            
        }catch _{
            
        }
        
        print("1")
        
        let roomQuery:PFQuery = PFQuery(className: "Room")
            
            print("2")
        
        roomQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            print("4")
            
            if objects!.count > 0 {
                
                print("5")
                
                for object in objects! {
                    
                    print("6")
                    
                    guard let theSender = object.objectForKey("Sender") as? PFUser else {
                        
                        print("no sender")
                        
                        return
                    }
                    
                    guard let theRecipient = object.objectForKey("Recipient") as? PFUser else {
                        
                        print("no recipient")
                        
                        return
                    }
                    
                    do {
                        
                        try theSender.fetch()
                        try theRecipient.fetch()
                        
                    }catch _{
                        
                    }
                    
                    if (theSender == self.currentUser && theRecipient == roomRecipient) || (theSender == roomRecipient && theRecipient == self.currentUser) {
                        
                        print("saved new message")
                        
                        self.sendMessageWithId(text,roomId: object.objectId!)
                        
                    }else {
                        
                        print("no room exist")
                        
                        chat["Description"] = text
                        chat["Sender"] = self.currentUser
                        
                        chat.saveInBackgroundWithBlock({ (success, error) -> Void in
                            
                            let relation:PFRelation = room.relationForKey("Messages")
                            room["Sender"] = self.currentUser
                            room["Recipient"] = roomRecipient
                            relation.addObject(chat)
                            room["Status"] = true
                            
                            room.saveInBackgroundWithBlock({ (success, error) -> Void in
                                
                                if success == true {
                                    
                                    print("message sent")
                                    
                                }else{
                                    
                                    print("message not sent")
                                }
                                
                            })
                        })
                    }
                }
                
            }else {
                
                chat["Description"] = text
                chat["Sender"] = self.currentUser
                
                chat.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    print("3")
                    
                    room["Sender"] = self.currentUser
                    room["Recipient"] = roomRecipient
                    let relation:PFRelation = room.relationForKey("Messages")
                    relation.addObject(chat)
                    room["Status"] = true
                    
                    room.saveInBackgroundWithBlock({ (success, error) -> Void in
                        
                        print("saved message")
                        
                        if success == true {
                            
                            print("text message sent")
                            
                            SwiftEventBus.post("SendMessage", sender: success)
                            
                        }else {
                            
                            print("text message not  sent")
                            
                            SwiftEventBus.post("SendMessage", sender: success)
                        }
                    })
                })
            }
            
        }
        
    }
    
    func sendImage(media:UIImage!,recipient:String!){
        
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
                    
                    self.sendImageWithId(media, roomId: object.objectId!)
                }
            }
        }
        
    }
    
    func sendMessageWithId(text:String!,roomId:String){
        
        let roomQuery:PFQuery = PFQuery(className: "Room")
        let chat = PFObject(className: "Message")
        
        roomQuery.getObjectInBackgroundWithId(roomId) { (room, error) -> Void in
            
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
                        SwiftEventBus.post("SendMessage", sender: success)
                        
                    }else {
                        
                        print("text message not  sent")
                        SwiftEventBus.post("SendMessage", sender: success)
                    }
                })
            })
        }
        
        }
    
    func sendImageWithId(media:UIImage!,roomId:String){
        
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
        }
        
    }
    
    func getRooms(){
        
        print("fired room func")
        
        let roomQuery:PFQuery = PFQuery(className: "Room")
        
        roomQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            print("fired room query")
            
            if let objects = objects  {
                
                for object in objects {
                    
                    print("fired loop")
                    
                    guard let theSender = object.objectForKey("Sender") as? PFUser else {
                        
                        print("no sender")
                        
                        return
                    }
                    
                    print("guard1")
                    
                    guard let theRecipient = object.objectForKey("Recipient") as? PFUser else {
                        
                        print("no Recipient")
                        
                        return
                    }
                    print("guard2")
                    
                    guard let theStatus = object.objectForKey("Status") as? Bool else {
                        
                        print("no status")
                        
                        return
                    }
                    
                    print("guard3")
                    
                    do {
                        
                        try theSender.fetch()
                        try theRecipient.fetch()
                        
                    }catch _ {
                        
                    }
                    
                    guard let icon:PFFile = theSender.objectForKey("ProfileImage") as? PFFile else {
                        
                        print("no icon")
                        
                        return
                    }
                    
                    print("guard4")
                    
                    guard let name:String = theSender.objectForKey("username") as? String else {
                        
                        print("no icon")
                        
                        return
                    }
                    
                    print("guard5")
                    
                    if theSender.objectId == self.currentUser?.objectId || theRecipient.objectId == self.currentUser?.objectId {
                        
                        let theRoom = Rooms(theObjectId: object.objectId!, theRecipiant: theRecipient.objectId!, theCreatedBy: theSender.objectId!, theStatus: theStatus, theTime: object.updatedAt!,theIcon: icon.url!,theName:name)
                        
                        self.roomArray.append(theRoom)
                        
                        print("added room")
                        
                    }
                }
                
                SwiftEventBus.post("Rooms", sender: self.roomArray)
                
            }else {
                
                print("no objects")
            }
            
            
        }
    }

}

