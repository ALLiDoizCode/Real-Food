//
//  ProfileViews.swift
//  Real Food
//
//  Created by Jonathan Green on 6/9/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material
import Cartography

class ProfileViews {
    
    func makeSeller(home:TextField,phone:TextField,button:FlatButton) {
        
        
        constrain(home, phone, button) { (home, phone, button) in
            
            home.width == (home.superview?.width)! * 0.8
            home.height == 50
            home.top == (home.superview?.top)! + 20
            home.centerX == (home.superview?.centerX)!
            
            phone.width == (home.superview?.width)! * 0.8
            phone.height == 50
            phone.top == home.bottom + 20
            phone.centerX == (home.superview?.centerX)!
            
            button.width == 100
            button.height == 50
            button.top == phone.bottom + 20
            button.centerX == (home.superview?.centerX)!
        }
        
        home.placeholder = "Street Address City State Zip"
        home.font = RobotoFont.regularWithSize(20)
        home.textColor = UIColor.flatWhiteColor()
        home.titleLabel = UILabel()
        home.titleLabel!.font = RobotoFont.mediumWithSize(12)
        home.titleLabelColor = MaterialColor.grey.base
        home.titleLabelActiveColor = UIColor.flatSandColorDark()
        home.backgroundColor = UIColor.clearColor()
        home.clearButtonMode = .Always
        
        phone.placeholder = "Phone"
        phone.font = RobotoFont.regularWithSize(20)
        phone.textColor = UIColor.flatWhiteColor()
        phone.titleLabel = UILabel()
        phone.titleLabel!.font = RobotoFont.mediumWithSize(12)
        phone.titleLabelColor = MaterialColor.grey.base
        phone.titleLabelActiveColor = UIColor.flatSandColorDark()
        phone.backgroundColor = UIColor.clearColor()
        phone.clearButtonMode = .Always
        
        
        button.setTitle("Done", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.flatPlumColorDark()
        button.titleLabel?.textColor = UIColor.flatSandColorDark()
    }
    
    func makeButton(veggie:FabButton,sweets:FabButton,dariy:FabButton,eggs:FabButton,poultry:FabButton,bovine:FabButton,goat:FabButton,lamb:FabButton,beer:FabButton,addButton:FabButton,camera:FabButton,addItem:FabButton,cancle:FabButton,controller:UIViewController,completion:(veggie:FabButton,sweets:FabButton,dariy:FabButton,eggs:FabButton,poultry:FabButton,bovine:FabButton,goat:FabButton,lamb:FabButton,beer:FabButton,addButton:FabButton,camera:FabButton,addItem:FabButton,cancle:FabButton) -> Void){
        
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
        
        completion(veggie: veggie, sweets: sweets, dariy: dariy, eggs: eggs, poultry: poultry, bovine: bovine, goat: goat, lamb: lamb, beer: beer, addButton: addButton, camera: camera, addItem: addItem, cancle: cancle)
    }
    
    func makeTextFields(itemTitle:TextField,controller:FoodViewController){
        
        itemTitle.placeholder = "Description"
        itemTitle.font = RobotoFont.regularWithSize(20)
        itemTitle.textColor = UIColor.flatWhiteColor()
        itemTitle.titleLabel = UILabel()
        itemTitle.titleLabel!.font = RobotoFont.mediumWithSize(12)
        itemTitle.titleLabelColor = MaterialColor.grey.base
        itemTitle.titleLabelActiveColor = UIColor.flatSandColorDark()
        itemTitle.backgroundColor = UIColor.clearColor()
        itemTitle.clearButtonMode = .Always
        controller.newItemView.addSubview(itemTitle)
    }
}
