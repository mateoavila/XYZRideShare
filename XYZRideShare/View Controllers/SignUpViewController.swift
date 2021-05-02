//
//  SignUpViewController.swift
//  XYZRideShare
//
//  Created by Mateo Avila on 4/30/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var userSwitch: UISegmentedControl!
    var useCase = "rider"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }

    func validateUserInfo() -> String? {
        
        //checks if filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        
        
        
        
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateUserInfo()
        
        if error != nil{
            displayError(error!)
        }else{
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //CEATE USER
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                if err != nil  {
                    //there is an error
                    self.displayError("error creating user")
                }else{
                    // user added and stored
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(result!.user.uid).setData(["firstName" : firstName, "lastName": lastName, "useCase": self.useCase, "uid": result!.user.uid])
                    
                    /*db.collection("users").addDocument(data: ["firstName" : firstName, "lastName": lastName, "useCase": self.useCase, "uid": result!.user.uid]) { error in
                        if error != nil {
                            self.displayError("something went wrong saving user data")
                            
                        }
                    }*/
                    
                    // MOVE TO HOME
                    if self.useCase == "rider" {
                        self.transitionToRideScreen()
                    }else{
                        self.transitionToDriveScreen()

                    }
                    
                }
            }
            
        }
    }
    
    func displayError(_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    
    func transitionToDriveScreen() {
        let driveViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.driverViewController) as? DriverViewController
        
        view.window?.rootViewController = driveViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToRideScreen() {
        let rideViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.riderViewController) as? RiderViewController
        
        view.window?.rootViewController = rideViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    
    @IBAction func useCaseChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            useCase = "rider"
        }else{
            useCase = "driver"
        }
    }
    
}
