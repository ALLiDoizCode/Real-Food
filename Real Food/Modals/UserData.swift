//
//  UserData.swift
//  Real Food
//
//  Created by Jonathan Green on 6/1/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class UserData {
    
    var userName:String!
    var profileImage:String!
    
    init(theUserName:String,theProfileImage:String){
        
        userName = theUserName
        profileImage = theProfileImage
    }
}