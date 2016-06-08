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
    
    let cloud = Cloud()
    
    func getRooms(){
        
        let roomQuery = PFQuery(className: "Room")
        roomQuery.whereKey("SenderId", equalTo: currentUser!.objectId!)
        
        let roomQuery2 = PFQuery(className: "Room")
        roomQuery2.whereKey("RecipientId", equalTo: currentUser!.objectId!)
        
        let query = PFQuery.orQueryWithSubqueries([roomQuery,roomQuery2])
        
        roomArray.removeAll()
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            print("found \(objects?.count) rooms")
            
            guard let objects:[PFObject] = objects else {
                
                print("no objects")
                
                return
            }
            
            for object in objects {
                
                guard let roomId = object.objectId else {
                    
                    print("no roomId")
                    
                    return
                }
                
                guard let status = object.objectForKey("Status") as? Bool else {
                    
                    print("no status")
                    
                    return
                }
                
                guard let sender = object.objectForKey("Sender") as? PFUser else {
                    
                    print("no Sender")
                    
                    return
                }
                
                guard let recipient = object.objectForKey("Recipient") as? PFUser else {
                    
                    print("no recipient")
                    
                    return
                }
                
                do {
                    
                    try sender.fetch()
                    try recipient.fetch()
                    
                }catch _{
                    
                }
                
                guard let senderName = sender.username else {
                    
                    print("no Sender username")
                    
                    return
                }
                
                guard let senderImage = sender.objectForKey("ProfileImage") as? PFFile else {
                    
                    print("no ProfileImage")
                    
                    return
                }
                
                
                guard let recipientName = recipient.username else {
                    
                    print("no recipient username")
                    
                    return
                }
                
                guard let recipientImage = recipient.objectForKey("ProfileImage") as? PFFile else {
                    
                    print("no recipient ProfileImage")
                    
                    return
                }
                
                if self.currentUser?.objectId == sender.objectId {
                    
                    let myRoom = Rooms(theObjectId: roomId, theRecipiant: recipient.objectId!, theCreatedBy: (self.currentUser?.objectId)!, theStatus: status, theTime: object.updatedAt!, theIcon: recipientImage.url!, theName: recipientName)
                    
                    self.roomArray.append(myRoom)
                    
                }else{
                    
                    let myRoom = Rooms(theObjectId: roomId, theRecipiant: (self.currentUser?.objectId)!, theCreatedBy: recipient.objectId!, theStatus: status, theTime: object.updatedAt!, theIcon: senderImage.url!, theName: senderName)
                    
                    self.roomArray.append(myRoom)
                }
                
            }
            
            SwiftEventBus.post("getRooms", sender: self.roomArray)
        }
        
    }
    
    func getMessage(roomID:String!){
        
        messageArray = []
        
        let messageQuery = PFQuery(className: "Message")
        
        messageQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            guard let objects:[PFObject] = objects else {
                
                return
            }
            
            for object in objects {
                
                guard let sender = object.objectForKey("Sender") as? PFUser else {
                    
                    print("no Sender")
                    
                    return
                }
                
                guard let description = object.objectForKey("Description") as? String else {
                    
                    print("no Description")
                    
                    return
                }
                
                guard let time = object.createdAt else {
                    
                    return
                }
                
                do {
                    
                    try sender.fetch()
                    
                }catch _{
                    
                }
                
                guard let profileImage = sender.objectForKey("ProfileImage") as? PFFile else {
                    
                    print("no ProfileImage")
                    
                    return
                }
                
                /*guard let media = object.objectForKey("Media") as? PFFile else {
                    
                    let myMessage = Message(theDescription: description, theMedia: "", theSender: sender.objectId!, theSenderImage: profileImage.url!, theTime: time, theSenderName: sender.username!)
                    
                    self.messageArray.append(myMessage)
                    
                    return
                }*/
                
                let myMessage = Message(theDescription: description, theMedia: "", theSender: sender.objectId!, theSenderImage: profileImage.url!, theTime: time, theSenderName: sender.username!)
                
                self.messageArray.append(myMessage)
            }
            
            SwiftEventBus.post("getMessages", sender: self.messageArray)
        }
    }
    
    func sendMessage(recipient:String,text:String) {
        
        var theRecipient:PFUser!
        let roomObject = PFObject(className: "Room")
        let messageObject = PFObject(className: "Message")
        
        messageObject["Description"] = text
        messageObject["Sender"] = currentUser
        
        let userQuery = PFUser.query()
        
        do {
            
            theRecipient = try userQuery?.getObjectWithId(recipient) as? PFUser
                
        }catch _{
            
        }
        
        print("the recipient username is \(theRecipient.username)")
        
        let roomQuery = PFQuery(className: "Room")
        roomQuery.whereKey("Sender", equalTo: currentUser!)
        roomQuery.whereKey("Recipient", equalTo: theRecipient!)
        
        let roomQuery2 = PFQuery(className: "Room")
        roomQuery2.whereKey("Sender", equalTo: theRecipient!)
        roomQuery2.whereKey("Recipient", equalTo: currentUser!)
        
        let query = PFQuery.orQueryWithSubqueries([roomQuery,roomQuery2])
        
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            
            guard let object:PFObject = object else {
                
                print("no rooms found for users")
                
                roomObject["Sender"] = self.currentUser
                roomObject["Recipient"] = theRecipient
                roomObject["SenderId"] = self.currentUser?.objectId
                roomObject["RecipientId"] = theRecipient.objectId
                roomObject["Status"] =  false
                
                roomObject.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    if success == true {
                        
                        
                        print("the room was created")
                        SwiftEventBus.post("sendMessage", sender: success)
                        
                    }else {
                        
                        print("there was in issue creating the chat room")
                        print(error)
                    }
                })
                
                return
            }
            
            guard let relation:PFRelation = object.relationForKey("Messages") else {
                
                return
            }
            
            if text != "" {
                
                messageObject.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    if success == true {
                        
                        print("Messaged saved")
                        
                        relation.addObject(messageObject)
                        
                        object.saveInBackgroundWithBlock({ (success, error) -> Void in
                            
                            if success == true {
                                
                                print("Messaged saved to room")
                                self.cloud.NewMessage(recipient)
                                SwiftEventBus.post("sendMessage", sender: success)
                                
                            }else {
                                
                                print("there was in issue creating the chat room")
                                print(error)
                            }
                        })
                    }else{
                        
                        print("there was in issue saving the message")
                        print(error)
                    }
                })
            }
            
           
            
        }
        
        
    }

}

