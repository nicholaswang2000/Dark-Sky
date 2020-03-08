//
//  SchoolViewController.swift
//  Dark Sky
//
//  Created by Nicholas Wang on 3/7/20.
//  Copyright © 2020 Nicholas Wang. All rights reserved.
//

import UIKit

class SchoolViewController: UIViewController {

    @IBOutlet weak var yesNoLbl: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var loadingLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var reasonLbl: UILabel!
    
    var progressTimer: Timer!
    let randomArr = ["Loading Machine Learning", "Doing some AI", "Calculating the Weathers", "Seeing if your classes are worth going to", "Calculating your shortest paths", "Decentralizing some blockchains", "Updating the progress bar", "Playing some Hearthstone", "Checking if ozone depletion will kill you today", "Analyzing wind patterns", "Seeing if you have anything better to do", "Calculating opportunity cost of skipping", "Getting your Internet of Things ready", "Buying Facebook and deleting it", "Modifying client user database", "Pulling additional API methods", "Eating a taco"]
    
    var curr: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yesNoLbl.text = ""
        reasonLbl.text = ""
        
        Helpers.designButtons(backBtn)

        progressBar.progress = 0.0
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 8)
        progressBar.layer.cornerRadius = 10
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = 10
        progressBar.subviews[1].clipsToBounds = true
        
        self.progressTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateProg), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func back(_ sender: Any) {
        progressTimer.invalidate()
        progressBar.progress = 0
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func updateProg() {
        progressBar.progress += 0.1
        progressBar.setProgress(progressBar.progress, animated: true)
        if (progressBar.progress == 1.0) {
            loadingLbl.text = ""
            progressTimer.invalidate()
            let f = Helpers.goToSchool(curr)
            reasonLbl.text = f
            if f == "" {
                yesNoLbl.text = "YES"
            } else {
                yesNoLbl.text = "NO"
            }
        } else {
            let number = Int.random(in: 0 ..< randomArr.count)
            loadingLbl.text = randomArr[number]
        }
    }

}
