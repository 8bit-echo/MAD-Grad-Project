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

//store the correct Spelling of the word
var wordToShuffle = currentGame2Word.correctSpelling

//Suffle the characters and store the letters to an array
var shuffledWord = Array(wordToShuffle.characters).shuffle()


class SecondViewController: UIViewController, UIGestureRecognizerDelegate {
    // set a life to hidden when an incorrect answer is given
    @IBOutlet weak var life1: UIImageView!
    @IBOutlet weak var life2: UIImageView!
    @IBOutlet weak var life3: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var letterOneTile: UIButton!
    @IBOutlet weak var letterTwoTile: UIButton!
    @IBOutlet weak var letterThreeTile: UIButton!
    @IBOutlet weak var letterFourTile: UIButton!
    
    var numberOfTiles = 0


    @IBAction func playAudioButton(sender: UIButton) {}
    
    
    @IBAction func letterTapped(sender: UIButton){
    
        // ******* TO DO *********
        
            //when a character is tapped, print it to the userInputLabel
            //disable the button or change it's text color for visual indication
    
    }
    
    
    @IBAction func startButton(sender: UIButton) {
        currentGame2Word = chooseWord()
        updateTiles()
    }
    
    
    func updateTiles(){
    
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
    // ******* TO DO *********
    // take shuffledWord and map each letter in the array to the corresponding tile
        
        
        print("updateTiles() has just finished running and returned the number \(numberOfTiles).")
        print("The current game word is '\(currentGame2Word.correctSpelling)'")
    }
    
    

    func checkWord(){
    // ******* TO DO *********
        // get the text from the userInputLabel
        // compare it to the correct spelling
        //notify user of results via score or lives
        
        
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentGame2Word = chooseWord()
        numberOfTiles = currentGame2Word.correctSpelling.characters.count
        
    }



}

