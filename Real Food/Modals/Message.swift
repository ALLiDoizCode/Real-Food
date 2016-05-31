//
//  Message.swift
//  Real Food
//
//  Created by Jonathan Green on 3/16/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class Message {
    
    let description:String!
    let media:String!
    let sender:String!
    let senderImage:String!
    let time:NSDate!
    let senderName:String!
    
    init(theDescription:String,theMedia:String,theSender:String,theSenderImage:String,theTime:NSDate,theSenderName:String){
        
        description = theDescription
        media = theMedia
        sender = theSender
        senderImage = theSenderImage
        time = theTime
        senderName = theSenderName
    }
}