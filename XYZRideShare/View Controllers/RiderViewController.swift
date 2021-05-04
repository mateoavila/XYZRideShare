//
//  RiderViewController.swift
//  XYZRideShare
//
//  Created by Mateo Avila on 5/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class RiderViewController: UIViewController {
    
    var timer = Timer()


    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var bookTripButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var arivedText: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var newRideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(newRideButton)
        newRideButton.alpha = 0
        Utilities.styleFilledButton(bookTripButton)
        arivedText.alpha = 0
        progressBar.progress = 0.0
        Utilities.styleHollowButton(rateButton)
        rateButton.alpha = 0
    }
    

    @IBAction func bookTripTapped(_ sender: Any) {
        topText.text = "Trip in Progress"
        var progress: Float = 0.0
        progressBar.progress = progress
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05,  repeats: true, block: {(timer) in
            

            progress += 0.01
            self.progressBar.progress = progress
            
            if  self.progressBar.progress == 1.0{
                self.topText.alpha = 0
                self.newRideButton.alpha = 1
                self.rateButton.alpha = 1
                self.arivedText.alpha = 1
                let  location = self.locationText.text
                self.arivedText.text = "You have arived at \(location ?? "your location")"
                
            }
            
        })
        let db = Firestore.firestore()
        db.collection("transaction").addDocument(data: ["rider" : Auth.auth().currentUser?.uid, "payment": 10])
        
    }
    
 
    @IBAction func newRideButtonTapped(_ sender: Any) {
        print("yep i got pressed")
        
        transitionRideScreen()
        

        
    }
    
    func transitionRideScreen() {
        let riderViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.riderViewController) as? RiderViewController
        
        view.window?.rootViewController = riderViewController
        view.window?.makeKeyAndVisible()
    }
    
    
}
