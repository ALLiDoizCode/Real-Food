//
//  PresenterEditing.swift
//  Real Food
//
//  Created by Jonathan Green on 6/6/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import UIKit
import SwiftEventBus

class PresenterEditing {

    let client = Editing()
    
    func delteObject(type:String,itemId:String,completion:(success:Bool) -> Void) {
        
        SwiftEventBus.onBackgroundThread(self, name: "Delete Item") { (result) in
            
            completion(success: result.object as! Bool)
        }
        
        client.delteObject(type, itemId: itemId)
    }
}