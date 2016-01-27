//
//  FoodCell.swift
//  Real Food
//
//  Created by Jonathan Green on 1/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material

class FoodCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.cellView.layer.cornerRadius = 3
            self.cellView.layer.masksToBounds = true
            
            self.mainLabel.font = RobotoFont.mediumWithSize(24)
            
        });
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
