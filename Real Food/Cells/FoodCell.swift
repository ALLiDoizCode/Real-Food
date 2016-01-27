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

    @IBOutlet weak var imageCard: ImageCardView!
    let titleLabel: UILabel = UILabel()
    let detailLabel: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.imageCard.clipsToBounds = true
            self.imageCard.masksToBounds = true
            self.imageCard.contentsScale = 1.6
            
            // Image.
            //let size: CGSize = CGSizeMake(UIScreen.mainScreen().bounds.width - CGFloat(40), 150)
            //imageCard.image = UIImage.imageWithColor(MaterialColor.cyan.darken1, size: size)
            
            // Title label.
            self.titleLabel.textColor = MaterialColor.white
            self.titleLabel.font = RobotoFont.mediumWithSize(24)
            self.imageCard.titleLabel = self.titleLabel
            self.imageCard.titleLabelInset.top = 100
            
            // Detail label.
            self.detailLabel.numberOfLines = 0
            self.imageCard.detailLabel = self.detailLabel
            
            // Yes button.
            let btn1: FlatButton = FlatButton()
            btn1.pulseColor = MaterialColor.cyan.lighten1
            btn1.pulseFill = true
            btn1.pulseScale = false
            btn1.setTitle("YES", forState: .Normal)
            btn1.setTitleColor(MaterialColor.cyan.darken1, forState: .Normal)
            
            // No button.
            let btn2: FlatButton = FlatButton()
            btn2.pulseColor = MaterialColor.cyan.lighten1
            btn2.pulseFill = true
            btn2.pulseScale = false
            btn2.setTitle("NO", forState: .Normal)
            btn2.setTitleColor(MaterialColor.cyan.darken1, forState: .Normal)
            
            // Add buttons to left side.
            self.imageCard.leftButtons = [btn1, btn2]
        });
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
