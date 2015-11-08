//
//  FirstViewController.swift
//  First Grade Spelling
//
//  Created by Megan Leahy on 10/18/15.
//  Copyright (c) 2015 Megan Leahy. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    // for the timer
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var startTimeDate = NSDate()
    var elapsedTime = NSTimeInterval()
    var elapsedTimeDate = NSDate()

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var life1: UIImageView!
    @IBOutlet weak var life2: UIImageView!
    @IBOutlet weak var life3: UIImageView!
    // set a life to hidden when an incorrect answer is given
    
    @IBAction func wordOne(sender: UIButton) {
    }
    @IBAction func wordTwo(sender: UIButton) {
    }
    @IBAction func wordThree(sender: UIButton) {
    }
    
    @IBOutlet weak var startIcon: UIButton!
    @IBAction func startButton(sender: UIButton) {
        var buttonLabel = sender as UIButton
        if !timer.valid {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTimeDate = NSDate()
            startTime = NSDate.timeIntervalSinceReferenceDate() + elapsedTime
            buttonLabel.setTitle("Pause", forState: UIControlState.Normal)
            //buttonLabel.setImage(UIImage(named: "pause-button"), forState: UIControlState.Normal)
            
            // start the game
            
        } else {
            buttonLabel.setTitle("Play", forState: UIControlState.Normal)
            //buttonLabel.setImage(UIImage(named: "play-button"), forState: UIControlState.Normal)
            elapsedTime += startTimeDate.timeIntervalSinceNow
            timer.invalidate()
            
            // pause the game
        }

    }
    
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime: NSTimeInterval = currentTime - startTime
        let minutes = UInt8(elapsedTime/60)
        elapsedTime -= (NSTimeInterval(minutes)*60)
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        let minutesString = String(format: "%02d", minutes)
        let secondsString = String(format: "%02d", seconds)
        
        timerLabel.text = "\(minutesString):\(secondsString)"
    }


    
    override func viewDidLoad() {
        timerLabel.text = "00:00"
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

