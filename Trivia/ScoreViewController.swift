//
//  ScoreViewController.swift
//  Trivia
//
//  Created by Kiki van Rongen on 14-05-18.
//  Copyright © 2018 Kiki van Rongen. All rights reserved.
//

import UIKit
import Firebase

class ScoreViewController: UIViewController {

    // MARK: Outlets & Actions
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameTextfield: UITextField!
    
    
    @IBOutlet weak var scoreButton: UIButton!
    @IBAction func submitScoreTapped(_ sender: UIButton) {
        
        // store score in database
        if nameTextfield.text?.isEmpty == false {
            self.ref.child("users").child(nameTextfield.text!).setValue(response!)
            nameTextfield.text = ""

        } else {
            self.ref.child("users").child("ANONYMOUS").setValue(response!)
        }
        
        // show completion image and disable submit button
        checkmarkImage.isHidden = false
        scoreButton.isEnabled = false
    }
    
    @IBOutlet weak var checkmarkImage: UIImageView!
    
    var response: Int!
    
    // create Firebase reference
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // disable image and set title
        checkmarkImage.isHidden = true
        navigationItem.title = "Results"
        
        // calculate average score and display to user
        scoreLabel.text = String(response/10)
        
        // hide back button
        navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
