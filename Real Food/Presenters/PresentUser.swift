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
    
    func makeUser(userName:String, passWord: String, email: String, image: UIImage,completion:(success:Bool) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "signUp") { notification in
            
            print("signUp fired")
            
            let success = notification.object as! Bool
            
            completion(success:success)
        }
        
        client.signUp(userName, passWord: passWord, email: email, image: image)
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