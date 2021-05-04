//
//  HomeViewController.swift
//  XYZRideShare
//
//  Created by Mateo Avila on 4/30/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class DriverViewController: UIViewController {

    @IBOutlet weak var tripRequestText: UILabel!
    @IBOutlet weak var acceptText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var arivedText: UILabel!
    @IBOutlet weak var startDriveButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var nextCustomerButton: UIButton!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arivedText.alpha = 0
        progressBar.progress = 0.0
        nextCustomerButton.alpha = 0
        Utilities.styleFilledButton(nextCustomerButton)
        Utilities.styleFilledButton(startDriveButton)
        Utilities.styleHollowButton(rateButton)
        rateButton.alpha = 0
    }
    

    @IBAction func startDriveTapped(_ sender: Any) {
        tripRequestText.alpha = 0
        acceptText.text = "Ride Accepted"
        var progress: Float = 0.0
        progressBar.progress = progress
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05,  repeats: true, block: {(timer) in
            
            progress += 0.01
            self.progressBar.progress = progress
            
            if  self.progressBar.progress == 1.0{
                self.acceptText.alpha = 0
                self.rateButton.alpha = 1
                self.nextCustomerButton.alpha = 1
                self.arivedText.alpha = 1
                
                
                self.arivedText.text = "You have arived at your location"
                
            }
            
        })
        let db = Firestore.firestore()
        db.collection("transaction").addDocument(data: ["driver" : Auth.auth().currentUser?.uid, "payment": 10])
        
    }
    
    @IBAction func rateButtonTapped(_ sender: Any) {
    }
    
    @IBAction func nextCustomerTapped(_ sender: Any) {
        transitionDriveScreen()

    }
    
    
    func transitionDriveScreen() {
        let driverViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.driverViewController) as? DriverViewController
        
        view.window?.rootViewController = driverViewController
        view.window?.makeKeyAndVisible()
    }
}
