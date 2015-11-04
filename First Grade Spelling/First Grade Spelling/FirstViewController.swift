//
//  FirstViewController.swift
//  First Grade Spelling
//
//  Created by Megan Leahy on 10/18/15.
//  Copyright (c) 2015 Megan Leahy. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

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
    
    @IBAction func startButton(sender: UIButton) {
        chooseWord()
    }
    
    var wordInfo = NSDictionary()
    var word = [String: [String: String]]()
    var words = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // gets the words (arrays) from the plist
        let path = NSBundle.mainBundle().pathForResource("SpellingWords", ofType: "plist")!
        wordInfo = NSDictionary(contentsOfFile: path)!
        words = sorted(wordInfo.allKeys as! [String])
        println(words)
    }

    func chooseWord() {
        var randomIndex = Int(arc4random_uniform(UInt32(words.count)))
        println(words[randomIndex])
        
        // now we need a way to get to the strings in the "word" dictionary
        // also need to assign the BOOL to true when the word has been choosen so it can't be choosen again
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

