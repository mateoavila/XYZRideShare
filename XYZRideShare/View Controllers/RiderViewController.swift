//
//  RiderViewController.swift
//  XYZRideShare
//
//  Created by Mateo Avila on 5/1/21.
//

import UIKit

class RiderViewController: UIViewController {
    
    var timer = Timer()

    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var bookTripButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var arivedText: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(bookTripButton)
        arivedText.alpha = 0
        progressBar.progress = 0.0
        Utilities.styleHollowButton(rateButton)
        rateButton.alpha = 0
    }
    

    @IBAction func bookTripTapped(_ sender: Any) {
        
        var progress: Float = 0.0
        progressBar.progress = progress
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05,  repeats: true, block: {(timer) in
            

            progress += 0.01
            self.progressBar.progress = progress
            
            if  self.progressBar.progress == 1.0{
                
                self.rateButton.alpha = 1
                self.arivedText.alpha = 1
                let  location = self.locationText.text
                
                self.arivedText.text = "You have arived at \(location ?? "your location")"
                
            }
            
        })
        
    }
    

}
