//
//  SecondViewController.swift
//  First Grade Spelling
//
//  Created by Megan Leahy on 10/18/15.
//  Copyright (c) 2015 Megan Leahy. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    // set a life to hidden when an incorrect answer is given
    @IBOutlet weak var life1: UIImageView!
    @IBOutlet weak var life2: UIImageView!
    @IBOutlet weak var life3: UIImageView!

    @IBAction func playAudioButton(sender: UIButton) {
    }
    
    // really not sure if this is the way to make this work
    @IBAction func letterOne(sender: UIButton) {
    }
    @IBAction func letterTwo(sender: UIButton) {
    }
    @IBAction func letterThree(sender: UIButton) {
    }
    @IBAction func letterFour(sender: UIButton) {
    }
    // each of letter square has a pan gesture recognizer:
    @IBAction func letterOneMoved(sender: UIPanGestureRecognizer) {
    }
    @IBAction func letterTwoMoved(sender: UIPanGestureRecognizer) {
    }
    @IBAction func letterThreeMoved(sender: UIPanGestureRecognizer) {
    }
    @IBAction func letterFourMoved(sender: UIPanGestureRecognizer) {
    }
    
    @IBAction func startButton(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

