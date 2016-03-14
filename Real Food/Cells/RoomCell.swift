//
//  RoomCell.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material

class RoomCell: UITableViewCell {
    
    var materialView:MaterialView!
    var theImage:UIImageView!
    var name:UILabel!
    var status:UILabel!
    var time:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .None
        
        materialView = MaterialView(frame: CGRectMake(10, 10, 50, 50))
        materialView.center.y = self.contentView.center.y
        materialView.shape = .Circle
        materialView.depth = .Depth2
        
        theImage = UIImageView(frame: CGRect(x: 0, y: 0, width: materialView.frame.width, height: materialView.frame.height))
        theImage.layer.cornerRadius = theImage.frame.height/2
        theImage.contentMode = .ScaleAspectFill
        theImage.image = UIImage(named: "girl")
        theImage.clipsToBounds = true
        theImage.layer.masksToBounds = true
        
        name = UILabel(frame: CGRect(x:materialView.frame.origin.x + 5, y: materialView.bounds.height + 5, width:self.contentView.frame.width, height: 50))
        name.font = RobotoFont.mediumWithSize(17)
        name.textColor = UIColor.flatPlumColorDark()
        
        status = UILabel(frame: CGRect(x:self.contentView.frame.width/3, y: 0, width:self.contentView.frame.width, height: 50))
        status.font = RobotoFont.mediumWithSize(17)
        status.center.y = self.contentView.center.y
        status.textColor = UIColor.flatPlumColorDark()
        
        time = UILabel(frame: CGRect(x:self.contentView.frame.width - 100, y: 0, width: 50, height: 50))
        time.font = RobotoFont.mediumWithSize(17)
        time.center.y = self.contentView.center.y
        time.textColor = UIColor.flatPlumColorDark()
        
        // Add materialView to UIViewController.
        materialView.addSubview(theImage)
        self.contentView.addSubview(materialView)
        self.contentView.addSubview(name)
        self.contentView.addSubview(status)
        self.contentView.addSubview(time)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
