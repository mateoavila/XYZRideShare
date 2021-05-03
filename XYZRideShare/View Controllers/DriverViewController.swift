//
//  HomeViewController.swift
//  XYZRideShare
//
//  Created by Mateo Avila on 4/30/21.
//

import UIKit

class DriverViewController: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var arivedText: UILabel!
    @IBOutlet weak var startDriveButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arivedText.alpha = 0
        progressBar.progress = 0.0
        Utilities.styleFilledButton(startDriveButton)
        Utilities.styleHollowButton(continueButton)
        continueButton.alpha = 0
    }
    

    @IBAction func startDriveTapped(_ sender: Any) {
        var progress: Float = 0.0
        progressBar.progress = progress
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05,  repeats: true, block: {(timer) in
            
            progress += 0.01
            self.progressBar.progress = progress
            
            if  self.progressBar.progress == 1.0{
                self.continueButton.alpha = 1

                self.arivedText.alpha = 1
                
                
                self.arivedText.text = "You have arived at your location"
                
            }
            
        })
        
    }
    

}
