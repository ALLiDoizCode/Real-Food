//
//  ProfileViews.swift
//  Real Food
//
//  Created by Jonathan Green on 6/9/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material

class ProfileViews {
    
    func makeButton(veggie:FabButton,sweets:FabButton,dariy:FabButton,eggs:FabButton,poultry:FabButton,bovine:FabButton,goat:FabButton,lamb:FabButton,beer:FabButton,addButton:FabButton,rating:FabButton,closeReview:RaisedButton,camera:FabButton,addItem:FabButton,cancle:FabButton,var edit:UIButton,controller:SellerProfileViewController,completion:(veggie:FabButton,sweets:FabButton,dariy:FabButton,eggs:FabButton,poultry:FabButton,bovine:FabButton,goat:FabButton,lamb:FabButton,beer:FabButton,addButton:FabButton,rating:FabButton,closeReview:RaisedButton,camera:FabButton,addItem:FabButton,cancle:FabButton,edit:UIButton) -> Void){
        
        let Menu = ["Veggies","Sweets","Dariy","Eggs","Poultry","Bovine","Goat","Lamb","Beer"]
        
        veggie.setImage(UIImage(named: Menu[0]), forState: UIControlState.Normal)
        sweets.setImage(UIImage(named: Menu[1]), forState: UIControlState.Normal)
        dariy.setImage(UIImage(named: Menu[2]), forState: UIControlState.Normal)
        eggs.setImage(UIImage(named: Menu[3]), forState: UIControlState.Normal)
        poultry.setImage(UIImage(named: Menu[4]), forState: UIControlState.Normal)
        bovine.setImage(UIImage(named: Menu[5]), forState: UIControlState.Normal)
        goat.setImage(UIImage(named: Menu[6]), forState: UIControlState.Normal)
        lamb.setImage(UIImage(named: Menu[7]), forState: UIControlState.Normal)
        beer.setImage(UIImage(named: Menu[8]), forState: UIControlState.Normal)
        
        veggie.imageView?.contentMode = .ScaleAspectFit
        sweets.imageView?.contentMode = .ScaleAspectFit
        dariy.imageView?.contentMode = .ScaleAspectFit
        eggs.imageView?.contentMode = .ScaleAspectFit
        poultry.imageView?.contentMode = .ScaleAspectFit
        bovine.imageView?.contentMode = .ScaleAspectFit
        goat.imageView?.contentMode = .ScaleAspectFit
        lamb.imageView?.contentMode = .ScaleAspectFit
        beer.imageView?.contentMode = .ScaleAspectFit
        
        veggie.backgroundColor = UIColor.flatPlumColorDark()
        sweets.backgroundColor = UIColor.flatPlumColorDark()
        dariy.backgroundColor = UIColor.flatPlumColorDark()
        eggs.backgroundColor = UIColor.flatPlumColorDark()
        poultry.backgroundColor = UIColor.flatPlumColorDark()
        bovine.backgroundColor = UIColor.flatPlumColorDark()
        goat.backgroundColor = UIColor.flatPlumColorDark()
        lamb.backgroundColor = UIColor.flatPlumColorDark()
        beer.backgroundColor = UIColor.flatPlumColorDark()
        
        veggie.tintColor = UIColor.flatSandColorDark()
        sweets.tintColor = UIColor.flatSandColorDark()
        dariy.tintColor = UIColor.flatSandColorDark()
        eggs.tintColor = UIColor.flatSandColorDark()
        poultry.tintColor = UIColor.flatSandColorDark()
        bovine.tintColor = UIColor.flatSandColorDark()
        goat.tintColor = UIColor.flatSandColorDark()
        lamb.tintColor = UIColor.flatSandColorDark()
        beer.tintColor = UIColor.flatSandColorDark()
        
        veggie.setTitle("", forState: UIControlState.Normal)
        sweets.setTitle("", forState: UIControlState.Normal)
        dariy.setTitle("", forState: UIControlState.Normal)
        eggs.setTitle("", forState: UIControlState.Normal)
        poultry.setTitle("", forState: UIControlState.Normal)
        bovine.setTitle("", forState: UIControlState.Normal)
        goat.setTitle("", forState: UIControlState.Normal)
        lamb.setTitle("", forState: UIControlState.Normal)
        beer.setTitle("", forState: UIControlState.Normal)
        
        veggie.imageEdgeInsets.top = 0
        veggie.imageEdgeInsets.bottom = 0
        veggie.imageEdgeInsets.right = -30
        veggie.imageEdgeInsets.left = 15
        
        sweets.imageEdgeInsets.top = 0
        sweets.imageEdgeInsets.bottom = 0
        sweets.imageEdgeInsets.right = -30
        sweets.imageEdgeInsets.left = 15
        
        dariy.imageEdgeInsets.top = 0
        dariy.imageEdgeInsets.bottom = 0
        dariy.imageEdgeInsets.right = -30
        dariy.imageEdgeInsets.left = 15
        
        eggs.imageEdgeInsets.top = 0
        eggs.imageEdgeInsets.bottom = 0
        eggs.imageEdgeInsets.right = -30
        eggs.imageEdgeInsets.left = 15
        
        poultry.imageEdgeInsets.top = 0
        poultry.imageEdgeInsets.bottom = 0
        poultry.imageEdgeInsets.right = -30
        poultry.imageEdgeInsets.left = 15
        
        bovine.imageEdgeInsets.top = 0
        bovine.imageEdgeInsets.bottom = 0
        bovine.imageEdgeInsets.right = -30
        bovine.imageEdgeInsets.left = 15
        
        goat.imageEdgeInsets.top = 0
        goat.imageEdgeInsets.bottom = 0
        goat.imageEdgeInsets.right = -30
        goat.imageEdgeInsets.left = 15
        
        lamb.imageEdgeInsets.top = 0
        lamb.imageEdgeInsets.bottom = 0
        lamb.imageEdgeInsets.right = -30
        lamb.imageEdgeInsets.left = 15
        
        beer.imageEdgeInsets.top = 0
        beer.imageEdgeInsets.bottom = 0
        beer.imageEdgeInsets.right = -30
        beer.imageEdgeInsets.left = 15
        
        addButton.backgroundColor = UIColor.flatPlumColorDark()
        addButton.tintColor = UIColor.flatSandColorDark()
        addButton.setImage(UIImage(named: "plus"), forState: UIControlState.Normal)
        addButton.imageEdgeInsets.top = 10
        addButton.imageEdgeInsets.bottom = 10
        addButton.imageEdgeInsets.right = 10
        addButton.imageEdgeInsets.left = 10
        
        rating.backgroundColor = UIColor.clearColor()
        rating.tintColor = UIColor.flatWhiteColor()
        rating.setTitle("4.3", forState: UIControlState.Normal)
        rating.titleLabel?.font = RobotoFont.mediumWithSize(32)
        
        closeReview.setTitle("Close", forState: .Normal)
        closeReview.titleLabel!.font = RobotoFont.mediumWithSize(32)
        closeReview.backgroundColor = UIColor.flatPlumColorDark()
        closeReview.setTitleColor(UIColor.flatSandColorDark(), forState: .Normal)
        
        edit.setTitle("Edit", forState: UIControlState.Normal)
        edit.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
       
        
        camera.setImage(UIImage(named: "camera"), forState: UIControlState.Normal)
        camera.tintColor = UIColor.flatSandColorDark()
        camera.backgroundColor = UIColor.flatPlumColorDark()
        camera.imageEdgeInsets.top = 10
        camera.imageEdgeInsets.bottom = 10
        camera.imageEdgeInsets.right = 10
        camera.imageEdgeInsets.left = 10
        
        addItem.setImage(UIImage(named: "plus"), forState: UIControlState.Normal)
        addItem.tintColor = UIColor.flatSandColorDark()
        addItem.backgroundColor = UIColor.flatPlumColorDark()
        addItem.imageEdgeInsets.top = 10
        addItem.imageEdgeInsets.bottom = 10
        addItem.imageEdgeInsets.right = 10
        addItem.imageEdgeInsets.left = 10
        
        cancle.setImage(UIImage(named: "close-box"), forState: UIControlState.Normal)
        cancle.tintColor = UIColor.flatSandColorDark()
        cancle.backgroundColor = UIColor.flatPlumColorDark()
        cancle.imageEdgeInsets.top = 10
        cancle.imageEdgeInsets.bottom = 10
        cancle.imageEdgeInsets.right = 10
        cancle.imageEdgeInsets.left = 10
        
        let rightButton = UIBarButtonItem.init(customView: edit)
        
        controller.navigationItem.rightBarButtonItem = rightButton
        
        completion(veggie: veggie, sweets: sweets, dariy: dariy, eggs: eggs, poultry: poultry, bovine: bovine, goat: goat, lamb: lamb, beer: beer, addButton: addButton, rating: rating, closeReview: closeReview, camera: camera, addItem: addItem, cancle: cancle, edit: edit)
    }
}
