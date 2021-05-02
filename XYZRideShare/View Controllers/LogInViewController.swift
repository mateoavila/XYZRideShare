//
//  LogInViewController.swift
//  XYZRideShare
//
//  Created by Mateo Avila on 4/30/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var logInButton: UIButton!
    
    var useCase = "rider"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
    }
    
    func setUpElements(){
        
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInButton)
    }

    
    @IBAction func logInTapped(_ sender: Any) {
        
        //check errors first :: todo
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }else{
              print("loged in")
            
            }
            
            let currentUser = Auth.auth().currentUser!.uid
             print("currentUser is \(currentUser)")
             let docRef = Firestore.firestore().collection("users").document(currentUser)

                     docRef.getDocument(source: .cache) { (document, error) in
                         if let document = document {
                             self.useCase = document.get("useCase") as! String
                             print("useCase is === \(self.useCase)")
                            
                            if self.useCase == "rider" {
                                self.transitionRideScreen()
                                print("going to \(self.useCase) screen")
                            }else{
                                self.transitionDriveScreen()
                                print("going to \(self.useCase) screen")
                            }
                            
                            
                         } else {
                             print("Document does not exist in cache")
                         }
                     }
            
        }
        
       

    }
    // validate user info
    
    func transitionDriveScreen() {
        let driverViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.driverViewController) as? DriverViewController
        
        view.window?.rootViewController = driverViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionRideScreen() {
        let riderViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.riderViewController) as? RiderViewController
        
        view.window?.rootViewController = riderViewController
        view.window?.makeKeyAndVisible()
    }
    
    
}
