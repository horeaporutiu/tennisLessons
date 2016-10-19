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
    
    init(Location: String, SkillLevel: String, DateTime: String) {
        self.mLocation = Location
        self.mSkillLevel = SkillLevel
        self.mDateTime = DateTime
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
        self.performSegueWithIdentifier("profile", sender: self)
        //lessonLabel.text =
        
        
       
        
        
    }
    
    @IBAction func backToLessons(sender: AnyObject) {
        self.performSegueWithIdentifier("backToLesson", sender: self)

    }
    
    
    @IBAction func submitLesson(sender: AnyObject) {
        
      
        
        let lessonsRef = self.rootRef.child("users").child("KmJA3BGL15WgEm9awEqbA193VUE3")
        
        let newRef = lessonsRef.childByAutoId()
        
        newRef.updateChildValues(["Time": self.time.text!, "Location": self.place.text!, "Skill Level": self.skill.text!])
        
       //let lesson = Lesson(Location: self.place.text!, SkillLevel: self.skill.text!, DateTime: self.time.text!)
        
        
    //setValue(["Time": self.time.text!, "Location": self.place.text!, "Skill Level": self.skill.text!])
       // DatabaseReference usersRef = ref.child("users");
        
        //Map<String, Lesson> users = new HashMap<String, Lesson>();
        //users.put("Lesson1", lesson);
        
        //self.rootRef.child("users").child("KmJA3BGL15WgEm9awEqbA193VUE3").child("Lessons" ).setValue(["Time": self.time.text!, "Location": self.place.text!, "Skill Level": self.skill.text!]);
        
        /*let baseRef = FIRDatabase.database().reference().child("users")
        
        
        baseRef.child("KmJA3BGL15WgEm9awEqbA193VUE3").child("Lessons").observeSingleEventOfType(.Value, withBlock:
            
            { (snapshot) in
                
                if (!snapshot.exists()) {
                    print ("oops")
                }
                else {
                    //self.label.text = String(snapshot.value)
                    self.label.text = String(snapshot.value)
                }
        })*/

        
        print("submitted")
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



















