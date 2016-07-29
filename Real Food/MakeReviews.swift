//
//  MakeReviews.swift
//  Real Food
//
//  Created by Jonathan Green on 7/29/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class MakeReview {
    
    func getItems() -> [Item] {
        
        var list:[Item] = []
        
        for i in 1 ..< 6 {
            
            let image = UIImage(named: "\(i)")
            
            let myItem = Item(theObjectId: "", theImage: image!, theDescription: "Lorem ipsum dolor", theProfileImage: UIImage(named: "girl")!, theUserName: "Sara", theName: "", theDistance: "15.2")
            
            list.append(myItem)
        }
        
        return list
    }
    
    func getReviews() -> [Review]{
        
        var reviewList:[Review] = []
        
        let rate = Int(arc4random_uniform(UInt32(5)))
        
        let myReview:Review = Review(theReview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eget purus ante. Proin in elit.", theRate: rate, theUser: "Jonathan")
        
        for _ in 0 ..< 6 {
            
            reviewList.append(myReview)
        }
        
        return reviewList
    }
    
    
}