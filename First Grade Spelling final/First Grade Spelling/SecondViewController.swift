//
//  SecondViewController.swift
//  First Grade Spelling
//
//  Created by Megan Leahy on 10/18/15.
//  Copyright (c) 2015 Megan Leahy. All rights reserved.
//

import UIKit
import AVFoundation

var game2Lives = 3
var game2Score = 0


//Choose a new word from the dictionary for this game
var currentGame2Word = chooseWord()

class SecondViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var life1: UIImageView!
    @IBOutlet weak var life2: UIImageView!
    @IBOutlet weak var life3: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var letterOneTile: UIButton!
    @IBOutlet weak var letterTwoTile: UIButton!
    @IBOutlet weak var letterThreeTile: UIButton!
    @IBOutlet weak var letterFourTile: UIButton!
    @IBOutlet weak var userInputLabel: UILabel!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var instructions: UITextView!
    @IBOutlet weak var gameOverText: UILabel!
    @IBOutlet weak var playAgainText: UIButton!
    @IBOutlet weak var birdImage: UIImageView!
    @IBOutlet weak var startIcon: UIButton!
    
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var startTimeDate = NSDate()
    var elapsedTime = NSTimeInterval()
    var elapsedTimeDate = NSDate()
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    var numberOfTiles = 0
    
    
    //Begin the Game
    @IBAction func startButton(sender: UIButton) {
        currentGame2Word = chooseWord()
        updateTiles()
        userInputLabel.text = ""
        hideView.hidden = true
        gameOverText.hidden = true
        
        let buttonLabel = sender as UIButton
        
        if !timer.valid {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTimeDate = NSDate()
            startTime = NSDate.timeIntervalSinceReferenceDate() + elapsedTime
            buttonLabel.setTitle("Pause", forState: UIControlState.Normal)
            hideView.hidden = true
            
            // start the game
            
        } else {
            buttonLabel.setTitle("Play", forState: UIControlState.Normal)
            elapsedTime += startTimeDate.timeIntervalSinceNow
            timer.invalidate()
            hideView.hidden = false
            instructions.hidden = true
            
            // pause the game
        }
        
    }
    
    //When a letter is selected, print it in the game.
    @IBAction func letterTapped(sender: UIButton){
        
        userInputLabel.hidden = false
        let buttonLetter = sender.titleLabel?.text
        let unwrappedLetter = buttonLetter!
        
        userInputLabel.text?.appendContentsOf(unwrappedLetter)
        
        //disable the button or change it's text color for visual indication
        sender.enabled = false
        
        checkWord()
        
    }
    
    //Update the Game Tiles
    func updateTiles(){
        
        numberOfTiles = currentGame2Word.correctSpelling.characters.count
        
        //Display the correct number of tiles
        switch numberOfTiles{
        case 4:
            letterOneTile.hidden = false
            letterTwoTile.hidden = false
            letterThreeTile.hidden = false
            letterFourTile.hidden = false
        case 3:
            letterOneTile.hidden = false
            letterTwoTile.hidden = false
            letterThreeTile.hidden = false
            letterFourTile.hidden = true
        case 2:
            letterOneTile.hidden = false
            letterTwoTile.hidden = false
            letterThreeTile.hidden = true
            letterFourTile.hidden = true
        default:
            break
        }
        
        // take shuffledWord and map each letter in the array to the corresponding tile
        var tileArray = [letterOneTile,letterTwoTile, letterThreeTile, letterFourTile]
        
        let wordToShuffle = currentGame2Word.correctSpelling
        let shuffledWord = Array(wordToShuffle.characters).shuffle()
        
        var i : Int
        for i = 0; i < shuffledWord.count; i++ {
            
            let tempLetter = String(shuffledWord[i])
            tileArray[i].setTitle(tempLetter, forState: UIControlState.Normal)
            tileArray[i].enabled = true
            
            print("letter \(tempLetter) has been mapped to tile \(i).")
            
        }
        
        print("updateTiles() has just finished running and returned the number \(numberOfTiles).")
        print("The current game word is '\(currentGame2Word.correctSpelling)'")
    }
    
    //Check for correct answer
    func checkWord(){
        
        // get the text from the userInputLabel
        let userAnswer = userInputLabel.text
        let correctAnswer = currentGame2Word.correctSpelling
        
        // compare it to the correct spelling. Final check is when all characters have been used
        if userAnswer == correctAnswer && userAnswer!.characters.count == correctAnswer.characters.count {
            
            userInputLabel.textColor = UIColor.greenColor()
            self.scoreLabel.text = String(++game2Score) + " words"
            if game2Score == 1{ self.scoreLabel.text = String(game2Score) + " word"}
            birdImage.hidden = false
            
            
            delay(0.75){
                currentGame2Word = chooseWord()
                self.updateTiles()
                self.userInputLabel.text = ""
                self.userInputLabel.textColor = UIColor.whiteColor()
                self.birdImage.hidden = true
                
                print("Correct word has been spelled")
            }
            
        }else{
            // do Nothing
            print("Still waiting for correct spelling")
        }
        
        // User used all letters and spelling is incorrect
        
        if userAnswer != correctAnswer && userAnswer!.characters.count == correctAnswer.characters.count {
            
            userInputLabel.textColor = UIColor.redColor()
            game2Lives--
            updateLives()
            
            delay(0.75){
                self.userInputLabel.text = ""
                self.userInputLabel.textColor = UIColor.whiteColor()
                self.updateTiles()
                print("User spelled word incorrectly")
            }
            
            //try again
            
        }
        
    }
    
    //Play the word via speech synthesizer
    @IBAction func playAudioButton(sender: UIButton) {
        myUtterance = AVSpeechUtterance(string: currentGame2Word.correctSpelling)
        myUtterance.rate = 0.4
        synth.speakUtterance(myUtterance)
    }
    
    //Timer begins counting
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime: NSTimeInterval = currentTime - startTime
        let minutes = UInt8(elapsedTime/60)
        elapsedTime -= (NSTimeInterval(minutes)*60)
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        let minutesString = String(format: "%02d", minutes)
        let secondsString = String(format: "%02d", seconds)
        
        timerLabel.text = "\(minutesString):\(secondsString)"
    }
    
    //Display correct number of lives
    func updateLives() {
        switch game2Lives{
            
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
            print("game over")
            //stop the timer somehow
            endGame()
        default:
            break
        }
        
        print("updateLives() has finished running")
        print("\(lives) lives remaining")
    }
    
    //End the game
    func endGame(){
        // pauses the timer
        timer.invalidate()
        hideView.hidden = false
        instructions.hidden = true
        gameOverText.hidden = false
        playAgainText.hidden = false
        birdImage.hidden = true
        startIcon.hidden = true
        
        
        
        print("endGame() has just finished running")
    }
    
    // Option to replay game
    @IBAction func playAgain(sender: UIButton) {
        viewDidLoad()
        game2Lives = 3
        game2Score = 0
        scoreLabel.text = "0 words"
        timerLabel.text = "00:00"
        hideView.hidden = false
        startIcon.hidden = false
        startIcon.setTitle("Start", forState: UIControlState.Normal)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentGame2Word = chooseWord()
        numberOfTiles = currentGame2Word.correctSpelling.characters.count
        scoreLabel.text = String(game2Score) + " words"
        gameOverText.hidden = true
        playAgainText.hidden =  true
        birdImage.hidden = true
        
    }
}

