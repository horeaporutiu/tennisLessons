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


class ViewController: UIViewController {

    @IBOutlet var place: UITextField!
    @IBOutlet var label: UILabel!
    
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
    
    @IBAction func submitLesson(sender: AnyObject) {
        self.rootRef.child("users").child("KmJA3BGL15WgEm9awEqbA193VUE3").child("Lesson" ).setValue(["Time": self.time.text!, "Location": self.place.text!, "Skill Level": self.skill.text!])
        
        //self.rootRef.child("users").child("KmJA3BGL15WgEm9awEqbA193VUE3").child("Lesson" ).setValue(["Location": self.place.text!])
        
        print("submitted")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                
    }
   
}
    

