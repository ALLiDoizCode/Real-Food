//
//  User.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import UIKit
import Parse
import SwiftEventBus

class User {
    
    let location = Location()
    
    let currentUser = PFUser.currentUser()
    
    func newSeller(phone:String,address:String) {
        
        currentUser!["Phone"] = phone
        currentUser!["Address"] = address
        currentUser!["ISSeller"] = true
        currentUser?.saveInBackgroundWithBlock({ (success, error) in
            
            SwiftEventBus.post("Make Seller", sender: success)
        })
    }
    
    func review(review:String!,rate:Int,sellerId:String){
        
        let reviewObject = PFObject(className: "Review")
        
        reviewObject["Review"] = review
        reviewObject["Rate"] = rate
        reviewObject["Seller"] = sellerId
        reviewObject["User"] = currentUser?.username
        
        reviewObject.saveInBackgroundWithBlock { (success, error) in
            
            SwiftEventBus.post("Review", sender: success)
        }
    }
    
    func getReviews(objectId:String) {
        
        var reviews:[Review] = []
        
        let query = PFQuery(className: "Review")
        query.whereKey("Seller", equalTo: objectId)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            
            guard let objects = objects else {
                
                return
            }
            
            for object in objects {
                
                let review = object.objectForKey("Review") as! String
                let rate = object.objectForKey("Rate") as! Int
                let user = object.objectForKey("User") as! String
                
                let myReview = Review(theReview: review, theRate: rate, theUser: user)
                
                reviews.append(myReview)
            }
            
            SwiftEventBus.post("myReviews", sender: reviews)
        }
    }
    
    func signUp(userName:String,passWord:String,email:String,image:UIImage){
        
        print("Signup fired")
        
        let imageData = NSData(data: UIImageJPEGRepresentation(image, 0.4)!)
        let file = PFFile(data: imageData)
        
        let user = PFUser()
        user.username = userName
        user.password = passWord
        user.email = email
        user["ISSeller"] = false
        user["ProfileImage"] = file
        
        location.oneShot { (coords) in
            
            print("location fired")
            
            let geoPoint = PFGeoPoint(latitude:coords.latitude, longitude:coords.longitude)
            
            user["Location"] = geoPoint
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo["error"] as? NSString
                    // Show the errorString somewhere and let the user try again.
                    
                    print(error.description)
                    
                    print("location not found")
                    
                    SwiftEventBus.post("signUp", sender: succeeded)
                    
                } else {
                    
                    print("location found")
                    
                    // Hooray! Let them use the app now.
                    
                    SwiftEventBus.post("signUp", sender: succeeded)
                    
                    print("User Created")
                }
            }
        }
        
    }
    
    func signUpSeller(userName:String,passWord:String,email:String,image:UIImage,myAddress:String){
        
        let imageData = NSData(data: UIImageJPEGRepresentation(image, 0.4)!)
        let file = PFFile(data: imageData)
        
        let user = PFUser()
        user.username = userName
        user.password = passWord
        user.email = email
        user["ProfileImage"] = file
        
        location.reverseAddress(myAddress) { (lat, long) -> Void in
            
            let geoPoint = PFGeoPoint(latitude:lat, longitude:long)
            
            user["Location"] = geoPoint
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo["error"] as? NSString
                    
                    print(errorString)
                    
                    SwiftEventBus.post("signUpSeller", sender: succeeded)
                    
                } else {
                    
                    SwiftEventBus.post("signUpSeller", sender: succeeded)
                    
                    print("Seller Created")
                }
            }
        }
    }
    
    func userData(){
        
        let profileImage = currentUser!.objectForKey("ProfileImage") as! PFFile
        let userName = currentUser?.username
        
        guard let phone:String = currentUser?.objectForKey("Phone") as? String else {
            
            let myData = UserData(theUserName: userName!, theProfileImage: profileImage.url!,thePhone:"")
            
            print(profileImage.url)
            
            SwiftEventBus.post("UserData", sender: myData)
            return
        }
        
        let myData = UserData(theUserName: userName!, theProfileImage: profileImage.url!,thePhone:phone)
        
        print(profileImage.url)
        
        SwiftEventBus.post("UserData", sender: myData)
    }
    
    func login(userName:String,PassWord:String){

        do {
            
            try PFUser.logInWithUsername(userName, password: PassWord)
            
            print("we logged in")
            
            SwiftEventBus.post("login", sender: true)
            // Do stuff after successful login.
            
        } catch {
            
            print("failed to login")
            
            SwiftEventBus.post("login", sender: false)
            // The login failed. Check error to see why.
        }

        /*PFUser.logInWithUsernameInBackground(userName, password:PassWord) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                
                SwiftEventBus.post("login", sender: true)
                // Do stuff after successful login.
                
            } else {
                
                print(error?.description)
                
                SwiftEventBus.post("login", sender: false)
                // The login failed. Check error to see why.
            }
        }*/
    }
    
    func logout(){
        
        PFUser.logOut()
    }
}