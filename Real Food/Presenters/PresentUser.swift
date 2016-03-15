//
//  PresentUser.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import SwiftEventBus

class PresentUser {
    
    let client = User()
    
    func makeUser(){
        
        client.signUp()
    }
    
    func login(userName:String,PassWord:String,completion:(success:Bool) -> Void) {
        
        SwiftEventBus.onBackgroundThread(self, name: "login") { notification in
            
            print("login fired")
            
            completion()
        }
        
        client.login(userName,PassWord:PassWord)
    }
}