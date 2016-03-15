//
//  PresentLIst.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import UIKit

class PresentList {
    
    
    
    let client = Listing()
    
    func makeItem(type:String, name: String,image:UIImage) {
        
        client.makeItem(type, name: name, image: image)
    }
}