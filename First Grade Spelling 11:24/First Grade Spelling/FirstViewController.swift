//
//  FirstViewController.swift
//  First Grade Spelling
//
//  Created by Megan Leahy on 10/18/15.
//  Copyright (c) 2015 Megan Leahy. All rights reserved.
//

import UIKit

var myDictionaryArray = [SpellingWord]()

//choose a random word from the dictionary
func chooseWord()  -> SpellingWord {
    
    let randomIndex = Int(arc4random_uniform(UInt32(myDictionaryArray.count)))
    let randomItem = myDictionaryArray[randomIndex]
    
    return randomItem
}

//stores the current word being displayed in the bubbles
var currentGameWord = chooseWord()

//stores the number of lives
var lives = 3


class FirstViewController: UIViewController {
    
    //Collection of global variables in the ViewController
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
    @IBOutlet weak var wordOneLabel: UIButton!
    @IBOutlet weak var wordTwoLabel: UIButton!
    @IBOutlet weak var wordThreeLabel: UIButton!
    @IBOutlet weak var startIcon: UIButton!
    
    
    
    // Begins the game and chooses a new word to display
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
        updateWords()
        
        println("startButton() has just finished running")
        
    }
    
    
    // This is the function that runs when a word is chosen by the user ( having a hard time with the resuing of words though.
    @IBAction func wordChosen(sender: UIButton) {
        if sender.titleLabel?.text == currentGameWord.correctSpelling {
            println("correct value chosen")
            currentGameWord = chooseWord()
            updateWords()
            currentGameWord.hasBeenUsed = true
            
        }else{
            lives -= 1
            updateLives()
            println("incorrect value chosen")
            currentGameWord = chooseWord()
            updateWords()
            currentGameWord.hasBeenUsed = true
            
        }
        
        while currentGameWord.hasBeenUsed == true {
            currentGameWord = chooseWord()
        }
        
        println("middleButton() has just finished running")
    }
    

    //update the words that are displayed in the bubbles
    func updateWords() {
        wordOneLabel.setTitle(currentGameWord.incorrectSpelling, forState: UIControlState.Normal)
        wordTwoLabel.setTitle(currentGameWord.correctSpelling, forState: UIControlState.Normal)
        wordThreeLabel.setTitle(currentGameWord.altIncorrectSpelling, forState: UIControlState.Normal)
        println("updateWords() has just finished running")
        
        

    }
    
    //Timer begins counting
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
    
    //changes the UIImages when the wrong answer is selected
    func updateLives() {
        switch lives{
        
        case 3:
            life1.image = UIImage(named: "heart.png")
            life2.image = UIImage(named: "heart.png")
            life3.image = UIImage(named: "heart.png")
        case 2:
            life1.image = UIImage(named: "heart.png")
            life2.image = UIImage(named: "heart.png")
            life3.image = UIImage(named: "empty.png")
        case 1:
            life1.image = UIImage(named: "empty.png")
            life2.image = UIImage(named: "heart.png")
            life3.image = UIImage(named: "empty.png")
        case 0:
            life1.image = UIImage(named: "empty.png")
            life2.image = UIImage(named: "empty.png")
            life3.image = UIImage(named: "empty.png")
        default:
            break
        }
        
        println("updateLives() has finished running")
    }



    
    override func viewDidLoad() {
        timerLabel.text = "00:00"
        lives = 3
        super.viewDidLoad()
        updateLives()
        //create the words for the dictionary
        let spellCat = SpellingWord(correctSpelling: "cat", incorrectSpelling: "kat", altIncorrectSpelling: "catt", hasBeenUsed: false)
        let spellJump = SpellingWord(correctSpelling: "jump", incorrectSpelling: "gump", altIncorrectSpelling: "jomp", hasBeenUsed: false)
        let spellDog = SpellingWord(correctSpelling: "dog", incorrectSpelling: "dogg", altIncorrectSpelling: "bog", hasBeenUsed: false)
        let spellFish = SpellingWord(correctSpelling: "fish", incorrectSpelling: "fesh", altIncorrectSpelling: "fiss", hasBeenUsed: false)
        
        // add words to the dictionary
        myDictionaryArray.append(spellCat)
        myDictionaryArray.append(spellJump)
        myDictionaryArray.append(spellDog)
        myDictionaryArray.append(spellFish)
        
 
    }



}

