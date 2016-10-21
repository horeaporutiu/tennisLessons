//
//  ViewController.swift
//  Horea Porutiu Tennis Lessons
//
//  Created by Horea on 9/27/16.
//  Copyright © 2016 Horea Porutiu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Lesson {
    internal var mLocation: String = "test"
    internal var mSkillLevel: String = "test"
    internal var mDateTime: String = "test"
    internal var mID : String = "test"
    
    init(Location: String, SkillLevel: String, DateTime: String, ID: String) {
        self.mLocation = Location
        self.mSkillLevel = SkillLevel
        self.mDateTime = DateTime
        self.mID = ID
        
    }
    
}


class Users {
    internal var mUsername: String = "test"
    internal var mPhoneNumber: String = "test"
    internal var mEmail: String = "a@gmail.com"
    internal var lessonArray = [Lesson]()
    
    init(Username: String, PhoneNumber: String, Email: String) {
        self.mUsername = Username
        self.mPhoneNumber = PhoneNumber
        self.mEmail = Email
    }
    
    
    
}


class ViewController: UIViewController, UITableViewDelegate
{
   
    @IBOutlet var date: UIDatePicker!
    
    var arr = []
    
    var cellContent = ["Rob", "Kirsten", "Tommy", "Ralphie"]
    
    @IBOutlet var place: UITextField!
    @IBOutlet var label: UILabel!
    
    
    
    
    @IBOutlet var profileLabel: UILabel!
    
    let rootRef = FIRDatabase.database().reference()
    
    let userID = FIRAuth.auth()?.currentUser?.uid
    
    @IBOutlet var time: UITextField!
    

    @IBOutlet var skill: UITextField!
    
    
    @IBOutlet var Username: UITextField!
    
    @IBOutlet var Password: UITextField!
    
    
    
    @IBAction func clickLogin(sender: AnyObject) {
        FIRAuth.auth()?.signInWithEmail(Username.text!, password: Password.text!, completion: {
            
            user, error in
            
            if error != nil {
                print("Error in pass or email!")
                let alertController = UIAlertController(title: "Error", message: "Email and Password combination is incorrect.", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                    print("OK")
                }
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            else {
                print("Huzzah!")
                self.performSegueWithIdentifier("login", sender: self)
                
                
                //self.rootRef.child("users").child(user!.uid).setValue(["username": self.Username.text!])
                //self.rootRef.child("users").child(user!.uid).child("Lesson" ).setValue(["Time": "hi"])

            }
            
        })
        
    }
    
    @IBOutlet var lessonLabel: UILabel!
    
    @IBAction func viewProfile(sender: AnyObject) {
        print("before profile segue")
    }
    
    
    @IBAction func backToLessons(sender: AnyObject) {
        //self.performSegueWithIdentifier("backToLesson", sender: self)

    }
    
    @IBAction func beginnerPressed(sender: AnyObject) {
        self.skill.text = "Beginner"
    }
    
    @IBAction func submitLesson(sender: AnyObject) {
        
        
        
        let alertController = UIAlertController(title: "Confirm Lesson", message: "Do you want to confirm this lesson? A confirmation will be sent to your Servr.", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            print("OK")
            let lessonsRef = self.rootRef.child("users").child("KmJA3BGL15WgEm9awEqbA193VUE3")
            
            let newRef = lessonsRef.childByAutoId()
            print(newRef)
            
            let lessonTime = NSDateFormatter.localizedStringFromDate(self.date.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
            
            newRef.updateChildValues(["Location": self.place.text!, "Skill Level": self.skill.text!, "Time": lessonTime, "ID": newRef])
            self.performSegueWithIdentifier("confirmation", sender: self)

            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (alert: UIAlertAction!) -> Void in
            //print("You pressed Cancel")
        }
        

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
        let baseRef = FIRDatabase.database().reference().child("users")
        

        baseRef.child("KmJA3BGL15WgEm9awEqbA193VUE3").child("Lessons").observeSingleEventOfType(.Value, withBlock:
        
        { (snapshot) in
                
                if (!snapshot.exists()) {
                    print ("oops")
                }
                else {
                    //self.label.text = String(snapshot.value)
                    print(snapshot.value)
            }
        })
    
    
    }
   
}



















