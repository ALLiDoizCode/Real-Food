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
    var phone:String!
    var rating:Int!
    var reviews:[String]!
    
    init(theUserName:String,theProfileImage:String,thePhone:String!){
        
        userName = theUserName
        profileImage = theProfileImage
        phone = thePhone
    }
}