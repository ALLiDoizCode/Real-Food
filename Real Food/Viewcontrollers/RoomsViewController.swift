//
//  RoomsViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class RoomsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    let menu = getMenu.sharedInstance
    let presenter = PresentMessages()
    var sellerId:String!
    var rooms:[Rooms] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.flatSandColor()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        presenter.getRooms { (data) -> Void in
            
            print("got rooms")
            
            self.rooms = data
            
            self.reload()
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.flatSandColorDark()
        menu.setupMenu(self,title:"Message")
        
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        
        menu.menuView.hide()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload(){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.tableView.reloadData()
        });
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rooms.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:RoomCell = tableView.dequeueReusableCellWithIdentifier("Room") as! RoomCell
        
        let status = rooms[indexPath.row].status
        
        cell.name.text = rooms[indexPath.row].name
        
        if status == true {
            
             cell.status.text = "New Message"
            
        }else{
            
            cell.status.text = "New Message"
        }
        
        let date = rooms[indexPath.row].time
        
        let time = NSDate().offsetFrom(date)
        
        cell.time.text = time
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "message" {
            
           let controller = segue.destinationViewController as! ChatRoomViewController
        }
    }
    

}
