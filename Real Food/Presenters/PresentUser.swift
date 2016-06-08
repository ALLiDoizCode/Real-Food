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

class PresentUser {
    
    let client = User()
    
    func getReviews(completion:(data:[Review],Rating:String) ->Void){
        
        SwiftEventBus.onMainThread(self, name: "myReviews") { (result) in
            
            var currentRating:Int! = Int()
            
            let reviews = result.object as! [Review]
            
            for review in reviews {
                
                currentRating = currentRating + review.rate
            }
            
            let rateFloat = Double(currentRating / reviews.count)
            
            let multiplier = pow(10.0, 1.0)
            
            let score = round(rateFloat * multiplier) / multiplier
            
            completion(data: reviews, Rating: "\(score)")
            
            SwiftEventBus.unregister(self, name: "myReviews")
        }
        
        client.getReviews()
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
    
    func makeUser(userName:String, passWord: String, email: String, image: UIImage,myAddress:String,phone:String,completion:(success:Bool) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "signUp") { notification in
            
            print("signUp fired")
            
            let success = notification.object as! Bool
            
            completion(success:success)
        }
        
        client.signUp(userName, passWord: passWord, email: email, image: image,myAddress:myAddress,phone:phone)
    }
    
    func login(userName:String,PassWord:String,completion:(success:Bool) -> Void) {
        
        SwiftEventBus.onMainThread(self, name: "login") { notification in
            
            print("login fired")
            
            let success = notification.object as! Bool
            
            completion(success:success)
        }
        
        client.login(userName,PassWord:PassWord)
    }
    
    func logout(){
        
       client.logout()
    }
}