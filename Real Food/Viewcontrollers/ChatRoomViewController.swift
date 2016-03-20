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
    let presenter = PresentMessages()
    
    var messageArray:[Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 246.0
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
          menu.setupMenu(self,title:"Messages")
        
      /* presenter.getMessages(roomId) { (data) -> Void in
        
            self.messageArray.removeAll()
            self.messageArray = data
            self.reload()
        }*/
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        menu.menuView.hide()
    }
    
    @IBAction func sendBtn(sender: AnyObject) {
        
       /* if textField.text != "" {
            
            presenter.sendMessage(textField.text!, recipient: sellerId, completion: { (success) -> Void in
                
                if success == true {
                    
                    self.presenter.getMessages(self.roomId) { (data) -> Void in
                        
                        self.messageArray.removeAll()
                        self.messageArray = data
                        self.reload()
                    }
                    
                }else {
                    
                    
                }
            })
        }*/
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
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let textarray = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus commodo orci non velit placerat, nec pharetra lorem auctor. Duis quis nisi fermentum, semper eros in, porta neque. Quisque non ex quis mi auctor bibendum. Proin eget ex lacus. Sed dictum varius pretium. Suspendisse maximus, odio vehicula faucibus convallis, tellus enim sagittis eros, nec blandit elit metus at est. Suspendisse potenti. Pellentesque purus mauris, congue sed ligula at, scelerisque vehicula mauris. Quisque in dolor mi. Vestibulum sed magna mi. Mauris eu justo tempor nibh efficitur dictum. Duis libero dolor, tempus nec nisl vitae, sollicitudin gravida turpis.","Vivamus justo velit, volutpat vitae elit eget, commodo convallis justo. Donec in rutrum lectus. Quisque ut maximus lacus, a mattis quam. Donec quis consectetur enim. Morbi lacus lacus, porta sed sagittis scelerisque, convallis eu turpis. Donec aliquam eros aliquam sapien hendrerit placerat. Morbi aliquam eleifend luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin bibendum augue erat, sed rhoncus ante malesuada vitae. Vivamus luctus augue hendrerit erat dapibus, vitae cursus magna mollis. Suspendisse turpis neque, tempor ut dignissim eu, dignissim nec sapien. Duis quis est a est ultrices consequat. Cras vestibulum nisi sed ipsum rhoncus, tempus vestibulum felis vestibulum. Praesent nec congue nibh. Morbi rutrum eu mi sit amet viverra.","Ut ullamcorper consectetur elit, non tempor est sodales vitae. Aliquam ornare, lectus sit amet rhoncus pellentesque, lacus urna tincidunt nibh, eu vehicula arcu magna non enim. Duis rutrum neque enim, quis porta nibh ultrices at. Morbi sed faucibus nisi, nec elementum sapien. Sed posuere sapien et magna pulvinar, quis ornare ipsum pellentesque. In ut tellus ut risus consectetur condimentum quis sit amet turpis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque ullamcorper laoreet magna, sit amet eleifend mi dictum non. Donec eu tempus odio. Mauris commodo velit quis elit varius, id tristique libero blandit. Vivamus sit amet bibendum arcu. Curabitur lacinia diam id suscipit cursus.","Praesent vitae blandit eros. In hac habitasse platea dictumst. Aliquam ac ante sem. In justo massa, malesuada id scelerisque a, venenatis at ante. Nunc semper malesuada dignissim. Sed vehicula scelerisque arcu ac gravida. Nam eu odio ligula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec porttitor mattis risus quis vehicula. Aenean lobortis non quam sit amet sagittis. Vivamus suscipit non tortor sit amet venenatis. Nulla dictum, risus a pharetra vestibulum, elit sem consequat tellus, et tincidunt velit purus et dui. Vivamus auctor vestibulum posuere. Donec venenatis mauris massa, vitae viverra justo bibendum id. Praesent non iaculis sapien. Aenean ullamcorper augue nec ante tristique, nec sollicitudin ante condimentum.","Quisque ornare vel mi ut eleifend. Duis tincidunt justo id ante eleifend vulputate. Maecenas sodales nunc sed facilisis lobortis. Cras efficitur, massa eu hendrerit ornare, arcu tortor condimentum lectus, eu cursus ligula lorem quis justo. Proin ac purus eu odio ullamcorper volutpat. Fusce molestie ligula leo, id dictum dolor condimentum sit amet. Fusce iaculis lacus ut placerat lobortis. Aenean fermentum arcu eu neque hendrerit pretium","Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus commodo orci non velit placerat, nec pharetra lorem auctor. Duis quis nisi fermentum, semper eros in, porta neque. Quisque non ex quis mi auctor bibendum. Proin eget ex lacus. Sed dictum varius pretium. Suspendisse maximus, odio vehicula faucibus convallis, tellus enim sagittis eros, nec blandit elit metus at est. Suspendisse potenti. Pellentesque purus mauris, congue sed ligula at, scelerisque vehicula mauris. Quisque in dolor mi. Vestibulum sed magna mi. Mauris eu justo tempor nibh efficitur dictum. Duis libero dolor, tempus nec nisl vitae, sollicitudin gravida turpis.","Vivamus justo velit, volutpat vitae elit eget, commodo convallis justo. Donec in rutrum lectus. Quisque ut maximus lacus, a mattis quam. Donec quis consectetur enim. Morbi lacus lacus, porta sed sagittis scelerisque, convallis eu turpis. Donec aliquam eros aliquam sapien hendrerit placerat. Morbi aliquam eleifend luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin bibendum augue erat, sed rhoncus ante malesuada vitae. Vivamus luctus augue hendrerit erat dapibus, vitae cursus magna mollis. Suspendisse turpis neque, tempor ut dignissim eu, dignissim nec sapien. Duis quis est a est ultrices consequat. Cras vestibulum nisi sed ipsum rhoncus, tempus vestibulum felis vestibulum. Praesent nec congue nibh. Morbi rutrum eu mi sit amet viverra.","Ut ullamcorper consectetur elit, non tempor est sodales vitae. Aliquam ornare, lectus sit amet rhoncus pellentesque, lacus urna tincidunt nibh, eu vehicula arcu magna non enim. Duis rutrum neque enim, quis porta nibh ultrices at. Morbi sed faucibus nisi, nec elementum sapien. Sed posuere sapien et magna pulvinar, quis ornare ipsum pellentesque. In ut tellus ut risus consectetur condimentum quis sit amet turpis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque ullamcorper laoreet magna, sit amet eleifend mi dictum non. Donec eu tempus odio. Mauris commodo velit quis elit varius, id tristique libero blandit. Vivamus sit amet bibendum arcu. Curabitur lacinia diam id suscipit cursus.","Praesent vitae blandit eros. In hac habitasse platea dictumst. Aliquam ac ante sem. In justo massa, malesuada id scelerisque a, venenatis at ante. Nunc semper malesuada dignissim. Sed vehicula scelerisque arcu ac gravida. Nam eu odio ligula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec porttitor mattis risus quis vehicula. Aenean lobortis non quam sit amet sagittis. Vivamus suscipit non tortor sit amet venenatis. Nulla dictum, risus a pharetra vestibulum, elit sem consequat tellus, et tincidunt velit purus et dui. Vivamus auctor vestibulum posuere. Donec venenatis mauris massa, vitae viverra justo bibendum id. Praesent non iaculis sapien. Aenean ullamcorper augue nec ante tristique, nec sollicitudin ante condimentum.","Quisque ornare vel mi ut eleifend. Duis tincidunt justo id ante eleifend vulputate. Maecenas sodales nunc sed facilisis lobortis. Cras efficitur, massa eu hendrerit ornare, arcu tortor condimentum lectus, eu cursus ligula lorem quis justo. Proin ac purus eu odio ullamcorper volutpat. Fusce molestie ligula leo, id dictum dolor condimentum sit amet. Fusce iaculis lacus ut placerat lobortis. Aenean fermentum arcu eu neque hendrerit pretium"]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("chat") as! ChatCell
        let cell2 = tableView.dequeueReusableCellWithIdentifier("chat2") as! ChatCell2
        
        /*if messageArray[indexPath.row].sender != currentUser?.objectId {
            
           
            dispatch_async(dispatch_get_main_queue(), {
                
                cell2.icon.kf_setImageWithURL(NSURL(string: self.messageArray[indexPath.row].senderImage)!, placeholderImage: UIImage(named: "placeholder"))
                cell2.name.text = self.messageArray[indexPath.row].senderName
                let date = self.messageArray[indexPath.row].time
                let time = NSDate().offsetFrom(date)
                cell2.time.text = time
                cell2.message.text = self.messageArray[indexPath.row].description
            
            });
            
            return cell2
            
        }else {
            
            
            
            dispatch_async(dispatch_get_main_queue(), {
                
                cell.icon.kf_setImageWithURL(NSURL(string: self.messageArray[indexPath.row].senderImage)!, placeholderImage: UIImage(named: "placeholder"))
                cell.name.text = self.messageArray[indexPath.row].senderName
                let date = self.messageArray[indexPath.row].time
                let time = NSDate().offsetFrom(date)
                cell.time.text = time
                cell.message.text = self.messageArray[indexPath.row].description
                
            });
            
             return cell
        }*/
        
        if indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7 || indexPath.row == 9 {
            
            //dispatch_async(dispatch_get_main_queue(), {
                
                cell2.icon.image = UIImage(named: "girl")
                cell2.name.text = "Fatime"
                //let date = "20s"
                //let time = date
                cell2.time.text = "20s"
                cell2.message.text = textarray[indexPath.row]
                
            //});

            return cell2
            
        }else{
            
            //dispatch_async(dispatch_get_main_queue(), {
                
                cell.icon.image = UIImage(named: "Jon")
                cell.name.text = "Jonathan"

                //let date = self.messageArray[indexPath.row].time
                //let time = NSDate().offsetFrom(date)
                cell.time.text = "20s"
                cell.message.text = textarray[indexPath.row]
                
            //});
            
            return cell
        }
        
       
    }

}






