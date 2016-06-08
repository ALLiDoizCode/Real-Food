//
//  ReviewCell2.swift
//  Real Food
//
//  Created by Jonathan Green on 6/8/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class ReviewCell2: UITableViewCell {
    
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var rate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

