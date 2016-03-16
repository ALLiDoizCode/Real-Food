//
//  Location.swift
//  Real Food
//
//  Created by Jonathan Green on 3/16/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import SwiftLocation
import CoreLocation



class Location {
    
    /*func oneShot(){
        
        do {
            
            try SwiftLocation.shared.currentLocation(Accuracy.Neighborhood, timeout: 20, onSuccess: { (location) -> Void in
                // location is a CLPlacemark
                
                let myCoords = location?.coordinate
                
                print(myCoords)
                
                }) { (error) -> Void in
                    // something went wrong
            }
            
        }catch _{
            
        }
        
    }*/
    
    func reverseAddress(myAddress:String){
        
        SwiftLocation.shared.reverseAddress(Service.Apple, address: myAddress, region: nil, onSuccess: { (place) -> Void in
            // our CLPlacemark is here
            }) { (error) -> Void in
                // something went wrong
        }
    }
    
    func reverseCoordinates(long:Double,lat:Double){
        
        let coordinates = CLLocationCoordinate2DMake(41.890198, 12.492204)
        
        SwiftLocation.shared.reverseCoordinates(Service.Apple, coordinates: coordinates, onSuccess: { (place) -> Void in
            // our placemark is here
            }) { (error) -> Void in
                // something went wrong
        }
    }
}