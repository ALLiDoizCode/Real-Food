//
//  FoodCell.swift
//  Real Food
//
//  Created by Jonathan Green on 1/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material
import FXBlurView
import Cartography

class FoodCell: UITableViewCell {
    
    var imageFadeView: MaterialView!
    var userIcon: UIImageView!
    var cellView: MaterialView!
    var cellImage: UIImageView!
    var mainLabel: MaterialLabel!
    var foodDescription: MaterialLabel!
    var distance:MaterialLabel!
    var distanceView:MaterialView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageFadeView = MaterialView()
        self.userIcon = UIImageView()
        self.cellView = MaterialView()
        self.cellImage = UIImageView()
        self.mainLabel = MaterialLabel()
        self.foodDescription = MaterialLabel()
        self.distance = MaterialLabel()
        self.distanceView = MaterialView()
        
        self.addSubview(self.cellView)
        cellView.addSubview(self.cellImage)
        cellView.addSubview(self.imageFadeView)
        cellView.addSubview(self.userIcon)
        cellView.addSubview(self.mainLabel)
        cellView.addSubview(self.foodDescription)
        cellView.addSubview(self.distanceView)
        distanceView.addSubview(self.distance)
        
        cellView.backgroundColor = UIColor.flatForestGreenColor()
        cellView.cornerRadius = .Radius1
        
        mainLabel.textColor = UIColor.flatSandColor()
        
        foodDescription.textColor = UIColor(contrastingBlackOrWhiteColorOn: cellView.backgroundColor, isFlat: true)
        
        constrain(userIcon) {userIcon in
            
            userIcon.height == 50
            userIcon.width == userIcon.height
            userIcon.left == (userIcon.superview?.left)! + 10
            userIcon.top == (userIcon.superview?.top)! + 10
            
            //self.userIcon.layer.borderColor = UIColor(complementaryFlatColorOf: cellView.backgroundColor).CGColor
            //self.userIcon.layer.borderWidth = 3
            self.userIcon.layer.cornerRadius = self.userIcon.layer.frame.height/2
            self.userIcon.layer.masksToBounds = true
            self.userIcon.clipsToBounds = true
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.SetupUI()
            
            self.selectionStyle = .None
            
            self.userIcon.layer.cornerRadius = self.userIcon.layer.frame.height/2
            
            self.userIcon.layer.masksToBounds = true
            
            self.cellImage.layer.cornerRadius = 4
            self.cellImage.layer.masksToBounds = true
            
            self.imageFadeView.layer.cornerRadius = 4
            self.imageFadeView.layer.masksToBounds = true

            self.foodDescription.font = RobotoFont.mediumWithSize(24)
            self.mainLabel.font = RobotoFont.mediumWithSize(17)
            
        });
        
    }
    
    func SetupUI(){
        
        cellImage.contentMode = .ScaleAspectFill
        cellImage.clipsToBounds = true
        
        imageFadeView.backgroundColor = UIColor.blackColor()
        imageFadeView.alpha = 0.3
        
        constrain(foodDescription,mainLabel,userIcon,imageFadeView,cellImage) { foodDescription,mainLabel,userIcon,imageFadeView,cellImage in
            
            mainLabel.left == userIcon.right + 5
            mainLabel.right == mainLabel.superview!.right - 5
            mainLabel.top == (mainLabel.superview?.top)! + 10
            
            foodDescription.left == userIcon.right + 5
            foodDescription.top == (mainLabel.bottom) + 5
            foodDescription.right == (foodDescription.superview?.right)! - 5
            
            cellImage.left == (cellImage.superview?.left)! + 10
            cellImage.right == (cellImage.superview?.right)! - 10
            cellImage.top == userIcon.bottom + 10
            cellImage.bottom == (foodDescription.superview?.bottom)! - 10
                
            imageFadeView.left == (imageFadeView.superview?.left)! + 10
            imageFadeView.right == (imageFadeView.superview?.right)! - 10
            imageFadeView.top == userIcon.bottom + 10
            imageFadeView.bottom == (imageFadeView.superview?.bottom)! - 10
           
        }
        
        constrain(cellView,distance,distanceView,cellImage) { cellView,distance,distanceView,cellImage in
            
            cellView.edges == inset(cellView.superview!.edges, 10, 10, 10, 10)
            
            distanceView.height == 50
            distanceView.width == distanceView.height
            distanceView.right == cellImage.right - 10
            distanceView.top == cellImage.top + 10
            
            self.distanceView.backgroundColor = UIColor(complementaryFlatColorOf: self.cellView.backgroundColor)
            self.distanceView.layer.cornerRadius = 25
            self.distanceView.layer.masksToBounds = true
            
            distance.center == (distance.superview?.center)!
            
            self.distance.text = "10m"
            self.distance.font = RobotoFont.mediumWithSize(17)
            self.distance.textColor = UIColor.flatSandColor()
        }
        
        

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
