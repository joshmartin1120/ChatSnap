//
//  ViewController.swift
//  ChatSnap
//
//  Created by Joshua Martin on 7/8/17.
//  Copyright © 2017 Joshua Martin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print ("Sign in attempted")
            if error != nil {
                print("Oh dagnabit bois")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("Tried to create user")
                    if error != nil {
                        print("error creating user")
                    } else {
                        print("all good bois")
                        self.performSegue(withIdentifier: "signInSegue", sender: Any?.self)
                    }
                })
            } else {
                print("Sign in succsessfull")
                self.performSegue(withIdentifier: "signInSegue", sender: Any?.self)
            }
            
        }
        
    }
    
}

