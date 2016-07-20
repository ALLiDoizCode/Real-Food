//
//  PresentUser.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import UIKit
import SwiftEventBus
import Parse

class PresentUser {
    
    let client = User()
    let Client2 = Editing()
    
    let currentUser = PFUser.currentUser()
    
    func makeSeller(phone:String,address:String) {
        
        SwiftEventBus.onBackgroundThread(self, name: "Make Seller") { (result) in
            
            let success = result.object as! Bool
            
            SwiftEventBus.postToMainThread("New Seller", sender: success)
        }
        
        client.newSeller(phone, address: address)
    }
    
    func isSeller() -> Bool {
        
        let status  = currentUser?.objectForKey("ISSeller") as! Bool
        
        return status
    }
    
    func editUser(userName:String,email:String,image:UIImage,myAddress:String,phone:String,completion:(success:Bool) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "Edit") { (result) in
            
            let success = result.object as! Bool
            
            completion(success: success)
        }
        
        Client2.editUser(userName, email: email, image: image, myAddress: myAddress, phone: phone)
    }
    
    func getReviews(objectId:String,completion:(data:[Review],Rating:String) ->Void){
        
        SwiftEventBus.onMainThread(self, name: "myReviews") { (result) in
            
            var currentRating:Double! = Double()
            
            let reviews = result.object as! [Review]
            
            for review in reviews {
                
                currentRating = currentRating + Double(review.rate)
                
            }
            
            let rateFloat:Double = currentRating / Double(reviews.count)
            
            print("my rating is \(rateFloat)")
            
            let score = String(format:"%.1f", rateFloat)
            
            completion(data: reviews, Rating: "\(score)")
            
            SwiftEventBus.unregister(self, name: "myReviews")
            
        }
        
        client.getReviews(objectId)
    }
    
    func makeReview(review:String!,rate:Int,sellerId:String,completion:(success:Bool) ->Void){
        
        SwiftEventBus.onMainThread(self, name: "Review") { (result) in
            
             let success = result.object as! Bool
            
             completion(success: success)
            
             SwiftEventBus.unregister(self, name: "Review")
        }
        
        client.review(review, rate: rate, sellerId: sellerId)
    }
    
    func userData(completion:(data:UserData) -> Void) {
        
        SwiftEventBus.onMainThread(self, name: "UserData") { (result) in
            
            let data = result.object as! UserData
            
            completion(data: data)
        }
        
        client.userData()
    }
    
    func makeUser(userName:String, passWord: String, email: String, image: UIImage,completion:(success:Bool) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "signUp") { notification in
            
            print("signUp fired")
            
            let success = notification.object as! Bool
            
            completion(success:success)
        }
        
        client.signUp(userName, passWord: passWord, email: email, image: image)
    }
    
    func login(userName:String,PassWord:String) {
        
        SwiftEventBus.onBackgroundThread(self, name: "login") { (notification) in
            
            print("login fired")
            
            let success = notification.object as! Bool
            
            SwiftEventBus.postToMainThread("Login Result", sender: success)
        }
        
        client.login(userName,PassWord:PassWord)
    }
    
    func logout(){
        
       client.logout()
    }
}