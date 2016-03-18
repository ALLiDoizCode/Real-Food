//
//  ChatCell.swift
//  Real Food
//
//  Created by Jonathan Green on 3/16/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var time1: UILabel!
    
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var time2: UILabel!
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
