//
//  Listing.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import Parse
import SwiftEventBus

class Listing {
    
    let currentUser = PFUser.currentUser()
    
    var itemArray:[Item] = []
    
    func getItems(type:String,miles:Double){
        
        self.itemArray.removeAll()
        
        var user:PFUser!
        
        let lists = PFQuery(className: type)
        lists.whereKey("Location", nearGeoPoint: (currentUser?.objectForKey("Location") as? PFGeoPoint)!, withinMiles: miles)
        
        lists.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            guard let objects = objects else {
                
                print("no objects")
                
                return
            }
            
            for object in objects {
                
                guard let image:PFFile = object.objectForKey("Image") as? PFFile else {
                    
                    print("no image")
                    
                    return
                }
                
                guard let description:String = object.objectForKey("Name") as? String else {
                    
                    print("no descrption")
                    
                    return
                }
                
                guard let createdBy:PFUser = object.objectForKey("CreatedBY") as? PFUser else {
                    
                    print("no user")
                    
                    return
                }
                
                guard let location:PFGeoPoint = object.objectForKey("Location") as? PFGeoPoint else {
                    
                    print("no location")
                    
                    return
                }
                
                do {
                    
                    try user = createdBy.fetch()
                    
                }catch _{
                    
                }
                
                if user != nil {
                
                    guard let userName = user.username else {
                        
                        print("no userName")
                        
                        return
                    }
                    
                    guard let profileImage:PFFile = user.objectForKey("ProfileImage") as? PFFile else {
                        
                        print("no profileImage")
                        
                        return
                    }
                    
                    
                    
                    
                    print(" the description \(description)")
                    print("the name \(userName)")
                    print("the user id \(user.objectId!)")
                    
                    let userLocation = self.currentUser?.objectForKey("Location") as! PFGeoPoint
                    
                    let miles = location.distanceInMilesTo(userLocation)
                    
                    //let multiplier = pow(10.0, 1.0)
                    
                    //let distance = round(miles * multiplier) / multiplier
                    
                    let itemDistance:String = String(format:"%.1f", miles)
                    
                    print("The distance is \(itemDistance)")
                    
                    let theItem = Item(theObjectId:user.objectId!, theImage: image.url!, theDescription: description,theProfileImage:profileImage.url!,theUserName:userName,theName:type,theDistance:itemDistance)
                    
                    theItem.type = type
                    
                    self.itemArray.append(theItem)
                    
                    
                }
                
                
            }
            
            SwiftEventBus.post("getItem", sender: self.itemArray)
        }
        
    }
    
    func getMyItems(){
        
        //self.itemArray.removeAll()
        
        self.itemArray = []
        
        let menuName:[String] = ["Veggies","Sweets","Dariy","Eggs","Poultry","Bovine","Goat","Lamb","Beer"]
        
        for name in menuName {
            
            print("start loop")
            
            let typeQuery = PFQuery(className: name)
            typeQuery.whereKey("CreatedBY", equalTo: currentUser!)
            
            queryTypes(typeQuery,name: name)
        }
        
        SwiftEventBus.post("myItems", sender: self.itemArray)
    }
    
    func queryTypes(lists:PFQuery,name:String){
        
        var objects:[PFObject]!
        
        do {
            
            try objects = lists.findObjects()
            
        }catch _ {
            
        }
        
        print("user created \(objects?.count)")
        
        for object in objects {
            
            guard let image:PFFile = object.objectForKey("Image") as? PFFile else {
                
                print("no image")
                
                return
            }
            
            guard let description:String = object.objectForKey("Name") as? String else {
                
                print("no descrption")
                
                return
            }
            
            guard let type:String = object.objectForKey("Type") as? String else {
                
                print("no Type")
                
                return
            }
            
            guard let userName = self.currentUser!.username else {
                
                print("no userName")
                
                return
            }
            
            guard let profileImage:PFFile = self.currentUser!.objectForKey("ProfileImage") as? PFFile else {
                
                print("no profileImage")
                
                return
            }
            
            print(" the description \(description)")
            print("the name \(userName)")
            print("the user id \(self.currentUser!.objectId!)")
            
            let theItem = Item(theObjectId:object.objectId!, theImage: image.url!, theDescription: description,theProfileImage:profileImage.url!,theUserName:userName,theName:name,theDistance: "")
            
            theItem.type = type
            
            self.itemArray.append(theItem)
            
        }
    }
    
    func makeItem(type:String,name:String,image:UIImage){
        
        let item = PFObject(className: type)
        
        let imageData = NSData(data: UIImageJPEGRepresentation(image, 0.4)!)
        let file = PFFile(data: imageData)
        
        item["Name"] = name
        item["Image"] = file
        item["CreatedBY"] = currentUser
        item["Location"] = currentUser?.objectForKey("Location") as? PFGeoPoint
        item["Type"] = type
        
        item.saveInBackgroundWithBlock { (success, error) -> Void in
        
            if success == true {
                
                SwiftEventBus.post("create", sender: success)
                
            }else {
                
                SwiftEventBus.post("create", sender: success)
            }
        }
    }
    
}


