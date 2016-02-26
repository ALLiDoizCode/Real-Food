//
//  sellerCell.swift
//  Real Food
//
//  Created by Jonathan Green on 1/27/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material

class sellerCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dispatch_async(dispatch_get_main_queue(), {
            
            self.cellView.layer.cornerRadius = 4
            self.cellView.layer.masksToBounds = true
            
            self.userIcon.layer.cornerRadius = self.userIcon.layer.frame.height/2
            self.userIcon.layer.masksToBounds = true
            
            self.distance.font = RobotoFont.mediumWithSize(17)
            self.userName.font = RobotoFont.mediumWithSize(17)
            
        });
        
       
    }
}
