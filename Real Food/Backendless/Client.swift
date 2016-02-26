//
//  Client.swift
//  Real Food
//
//  Created by Jonathan Green on 2/25/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class Client {
    
    let backendless = Backendless.sharedInstance()
    
    func regesterUser(){
        
        let user: BackendlessUser = BackendlessUser()
        user.email = "dev.jonathan.green@gmail.com"
        user.password = "123"
        backendless.userService.registering(user)
        
    }
    
    func addVeggie(){
        
        let veggie = Veggies()
        veggie.name = "Ghost Pepper"
        veggie.type = "Hot Pepper"
        backendless.persistenceService.of(Veggies.ofClass()).save(veggie)
    }
}