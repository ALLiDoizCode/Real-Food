//
//  Listing.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import Parse

class Listing {
    
    let veggies = "Veggies"
    let sweets = "Sweets"
    let poultry = "Poultry"
    let lamb = "Lamb"
    let goat = "Goat"
    let eggs = "Eggs"
    let dariy = "Dariy"
    let bovine = "Bovine"
    let beer = "Beer"
    
    let currentUser = PFUser.currentUser()
    
    func makeItem(type:String,name:String,image:UIImage){
        
        let item = PFObject(className: type)
        
        let imageData = NSData(data: UIImageJPEGRepresentation(image, 0.4)!)
        let file = PFFile(data: imageData)
        
        item["Name"] = name
        item["Image"] = file
        item["CreatedBY"] = currentUser
        
        do {
            
            try item.save()
            
        }catch _{
            
        }
    }
    
}


