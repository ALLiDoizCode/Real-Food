//
//  MenuCell.swift
//  Real Food
//
//  Created by Jonathan Green on 1/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import HanabiCollectionViewLayout

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var coverView: UIView!
    
    var minAlpha: CGFloat = 0
    let maxAlpha: CGFloat = 0.75
    
    override func awakeFromNib() {
        
       
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
    
            let layout = HanabiCollectionViewLayout()
            
            let standardHeight = layout.standartHeight
            let featuredHeight = layout.focusedHeight
            
            let delta = 1 - ((featuredHeight - CGRectGetHeight(self.frame)) / (featuredHeight - standardHeight))
            
            self.coverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
            let scale = max(delta, 0.5)
            Name.transform = CGAffineTransformMakeScale(scale, scale)
        
    }
    
}
