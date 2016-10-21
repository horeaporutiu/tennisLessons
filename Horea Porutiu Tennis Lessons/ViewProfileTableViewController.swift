//
//  ViewProfileTableViewController.swift
//  Horea Porutiu Tennis Lessons
//
//  Copyright © 2016 Horea Porutiu. All rights reserved.
//

import UIKit
import Firebase

class ViewProfileTableViewController: UITableViewController {
    
    var arr : [Lesson] = []
    
    let ref = FIRDatabase.database().reference().child("users").child("KmJA3BGL15WgEm9awEqbA193VUE3")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observeEventType(.Value, withBlock: {
        snapshot in
            
            self.arr = []
            
                
            //self.userNameLabel.text = String(snapshot.value!["username"]!)
            for snap in snapshot.children {
                print(snapshot.key)
                if let v = snap.value["Location"] as? String {
                    let time = snap.value["Time"] as! String
                    let skill = snap.value["Skill Level"] as! String
                    let id = (snap.key!) as! String
                    let lesson : Lesson = Lesson(Location: v, SkillLevel: skill, DateTime: time, ID: id)
                    self.arr.append(lesson)
                    print(snap.key!)
                    
                  
                }
                
                /*let username = snap.value["username"] as? String
                self.userNameLabel.text = username*/
                
                /*else if let username = snap.value["username"] as? String{
                    self.userNameLabel.text = username
                }*/
                //print(snap.va)
            }
            self.tableView.reloadData()

            
            /*for snaptest in snapshot {
                let username = snap.value["username"] as? String
                self.userNameLabel.text = username
            }*/
                
                /*let username = snap.value["username"] as? String {
                    self.userNameLabel.text = username
                }*/
                
                //print(snap.value["username"])
            })
            
    }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr.count
    }

    @IBOutlet var userNameLabel: UILabel!
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath)

        // Configure the cell...
        
        let timeLabel = cell.viewWithTag(1) as! UILabel
        let locationLabel = cell.viewWithTag(2) as! UILabel
        let skillLabel = cell.viewWithTag(3) as! UILabel
        let lessonLabel =
            cell.viewWithTag(4) as! UILabel
        
        let str = arr[indexPath.row].mDateTime
        let delimiter = ","
        let newstr = ""
        let dateStr = str.componentsSeparatedByString(delimiter)
        
        timeLabel.text = "Time:\(dateStr[1])"
        locationLabel.text = "Location: \(arr[indexPath.row].mLocation)"
        skillLabel.text = "Skill Level: \(arr[indexPath.row].mSkillLevel)"
        lessonLabel.text = "Lesson \(dateStr[0])"
        
        


        return cell
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let childID = arr[indexPath.row].mID
            print(childID)
            //let ref = FIRDatabase.database().reference().child("users").child("KmJA3BGL15WgEm9awEqbA193VUE3")
            self.arr.removeAtIndex(indexPath.row)
           ref.child(childID).removeValue();
            //ref.child(arr[indexPath.row].mID).removeValue();
            
            //print(arr[indexPath.row].mID)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
