//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let softTime = 5, midTime = 7, hardTime = 12
    var eggTime: [String : Int] = ["Soft": 3, "Medium":420, "Hard": 720];
    var timer = Timer ()
    var player: AVAudioPlayer!
    var totleTime = 0, secondPassed = 0
    
    
    @IBOutlet weak var timerHeader: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        timerHeader.text = "Timer for \(hardness) in progress"
        
        secondPassed = 0
        totleTime = eggTime[hardness]!
        progressBar.progress = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }

    @objc func updateCounter() {
        if  secondPassed < totleTime {
            secondPassed += 1
            progressBar.progress = Float(secondPassed) / Float(totleTime)
            
        } else {
            timer.invalidate()
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            timerHeader.text = "Done!"
            
            player = try! AVAudioPlayer(contentsOf: url!)
            player?.play()
        }
    }
    
}
