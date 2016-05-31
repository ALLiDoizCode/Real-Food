//
//  Rooms.swift
//  Real Food
//
//  Created by Jonathan Green on 3/16/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation


class Rooms {
    
    var objectId:String!
    var recipiant:String!
    var createdBy:String!
    var status:Bool!
    var time:NSDate!
    var icon:String!
    var name:String!
    init(theObjectId:String,theRecipiant:String,theCreatedBy:String,theStatus:Bool,theTime:NSDate,theIcon:String,theName:String){
        
        objectId = theObjectId
        recipiant = theRecipiant
        createdBy = theCreatedBy
        status = theStatus
        time = theTime
        icon = theIcon
        name = theName
    }
}