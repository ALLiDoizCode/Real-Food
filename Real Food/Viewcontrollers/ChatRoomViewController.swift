//
//  ChatRoomViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import ImagePickerSheetController
import Photos
import Parse


class ChatRoomViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var textField: UITextField!
    var userIcon:UIImage!
    var sellerId:String!
    var roomId:String!
    var selectedImage:UIImage!
    
    let currentUser = PFUser.currentUser()
    
    let menu = getMenu.sharedInstance

    
    
    var messageArray:[Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 246.0
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        menu.setupMenu(self,title:"Messages")
        
        }
    
    override func viewWillDisappear(animated: Bool) {
        
        menu.menuView.hide()
    }
    
    @IBAction func sendBtn(sender: AnyObject) {
        
       if textField.text != "" {
        
        print("the recipient is \(sellerId)")
            
          
        }
    }
    func reload(){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.tableView.reloadData()
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.messageArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("chat") as! ChatCell
        let cell2 = tableView.dequeueReusableCellWithIdentifier("chat2") as! ChatCell2
        
        if messageArray[indexPath.row].sender != currentUser?.objectId {
            
            cell2.message.text = self.messageArray[indexPath.row].description
           
            dispatch_async(dispatch_get_main_queue(), {
                
                cell2.icon.kf_setImageWithURL(NSURL(string: self.messageArray[indexPath.row].senderImage)!, placeholderImage: UIImage(named: "placeholder"))
                cell2.name.text = self.messageArray[indexPath.row].senderName
                let date = self.messageArray[indexPath.row].time
                let time = NSDate().offsetFrom(date)
                cell2.time.text = time
                
            
            });
            
            return cell2
            
        }else {
            
            cell.message.text = self.messageArray[indexPath.row].description
            
            dispatch_async(dispatch_get_main_queue(), {
                
                cell.icon.kf_setImageWithURL(NSURL(string: self.messageArray[indexPath.row].senderImage)!, placeholderImage: UIImage(named: "placeholder"))
                cell.name.text = self.messageArray[indexPath.row].senderName
                let date = self.messageArray[indexPath.row].time
                let time = NSDate().offsetFrom(date)
                cell.time.text = time
                
                
            });
            
             return cell
        }
        
    }

}






