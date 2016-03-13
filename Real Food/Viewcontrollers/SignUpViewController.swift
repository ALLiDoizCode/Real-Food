//
//  SignUpViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 3/13/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material

class SignUpViewController: UIViewController {

    @IBOutlet weak var buyer: FabButton!
    @IBOutlet weak var seller: FabButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.flatForestGreenColorDark()
        
        buyer.backgroundColor = UIColor.flatPlumColorDark()
        buyer.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
        seller.backgroundColor = UIColor.flatPlumColorDark()
        seller.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
        makeCard()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeCard(){
        
        let cardView: CardView = CardView()
        
        // Title label.
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "Are You A Buyer Or Seller"
        titleLabel.textColor = UIColor.flatSandColorDark()
        titleLabel.font = RobotoFont.mediumWithSize(20)
        cardView.titleLabel = titleLabel
        cardView.divider = false
        cardView.backgroundColor = UIColor.clearColor()
        
        /*// Detail label.
        let detailLabel: UILabel = UILabel()
        detailLabel.text = "It’s been a while, have you read any new books lately?"
        detailLabel.numberOfLines = 0
        //cardView.detailView = detailLabel
        
        // Yes button.
        let btn1: FlatButton = FlatButton()
        btn1.pulseColor = MaterialColor.blue.lighten1
        btn1.pulseFill = true
        btn1.pulseScale = false
        btn1.setTitle("YES", forState: .Normal)
        btn1.setTitleColor(MaterialColor.blue.darken1, forState: .Normal)
        
        // No button.
        let btn2: FlatButton = FlatButton()
        btn2.pulseColor = MaterialColor.blue.lighten1
        btn2.pulseFill = true
        btn2.pulseScale = false
        btn2.setTitle("NO", forState: .Normal)
        btn2.setTitleColor(MaterialColor.blue.darken1, forState: .Normal)
        
        // Add buttons to left side.
        cardView.leftButtons = [btn1, btn2]*/
        
        // To support orientation changes, use MaterialLayout.
        self.view.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        MaterialLayout.alignFromTop(view, child: cardView, top: 150)
        MaterialLayout.alignToParentHorizontally(view, child: cardView, left: 60, right: 20)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
