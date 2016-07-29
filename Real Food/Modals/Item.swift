//
//  Item.swift
//  Real Food
//
//  Created by Jonathan Green on 3/15/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class Item {
    
    var objectId:String!
    var image:UIImage!
    var description:String!
    var profileImage:UIImage!
    var userName:String!
    var name:String
    var distance:String!
    var type:String!
    
    init(theObjectId:String,theImage:UIImage,theDescription:String,theProfileImage:UIImage,theUserName:String!,theName:String,theDistance:String){
        
        objectId = theObjectId
        image = theImage
        description = theDescription
        profileImage = theProfileImage
        userName = theUserName
        name = theName
        distance = theDistance
    }
}