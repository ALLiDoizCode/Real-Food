//
//  Review.swift
//  Real Food
//
//  Created by Jonathan Green on 6/8/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
class Review {
    
    var review:String!
    var rate:Int!
    var user:String!
    
    init(theReview:String,theRate:Int,theUser:String){
        
        review = theReview
        rate = theRate
        user = theUser
    }
}