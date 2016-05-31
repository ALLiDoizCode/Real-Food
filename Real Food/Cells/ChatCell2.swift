//
//  ChatCell2.swift
//  Real Food
//
//  Created by Jonathan Green on 3/20/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class ChatCell2: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var message: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.icon.layer.cornerRadius = self.icon.frame.height/2
            self.icon.layer.masksToBounds = true
            
        });
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
