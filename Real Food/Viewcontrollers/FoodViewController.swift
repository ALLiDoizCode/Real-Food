//
//  FoodViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 1/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import ChameleonFramework

class FoodViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let cellIdentefier = "Food"

    @IBOutlet weak var TableView: UITableView!
    
    let imageArray:[String] = ["beans","carrots","cucumbers","greens","peas","peppers","tomatoes",]
    let titleArray:[String] = ["Beans","Carrots","Cucumbers","Greens","Peas","Peppers","Tomatoes",]
    let descriptionArray:[String] = ["Come get some tasty beans","Come get some tasty carrots","Come get some tasty cucumbers","Come get some tasty greens","Come get some tasty peas","Come get some tasty peppers","Come get some tasty tomatoes",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Veggies"
        
        self.TableView.backgroundColor = UIColor(contrastingBlackOrWhiteColorOn: self.navigationController?.navigationBar.barTintColor, isFlat: true)
        
        self.navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn:self.navigationController?.navigationBar.barTintColor, isFlat:true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:FoodCell = tableView.dequeueReusableCellWithIdentifier(cellIdentefier) as! FoodCell
        
        let image = UIImage(named: self.imageArray[indexPath.row])
        
         cell.contentView.backgroundColor = UIColor(contrastingBlackOrWhiteColorOn: self.navigationController?.navigationBar.barTintColor, isFlat: true)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let size: CGSize = CGSizeMake(cell.frame.width - CGFloat(40), cell.frame.height)
          
            cell.imageCard.image = image?.imageScaledToSize(size)
            //cell.imageCard.contentsScale = 1.8
            cell.titleLabel.text = self.titleArray[indexPath.row]
            cell.detailLabel.text = self.descriptionArray[indexPath.row]
            
            let imageColor = UIColor(averageColorFromImage: UIImage(named: self.imageArray[indexPath.row]))
            cell.imageCard.backgroundColor =  UIColor(complementaryFlatColorOf:imageColor)
            cell.titleLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn:imageColor, isFlat:true)
            cell.detailLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn:imageColor, isFlat:true)
            
        });
        
        return cell
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
