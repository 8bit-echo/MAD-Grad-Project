//
//  FirstViewController.swift
//  First Grade Spelling
//
//  Created by Megan Leahy on 10/18/15.
//  Copyright (c) 2015 Megan Leahy. All rights reserved.
//

import UIKit
import AVFoundation

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

//stores the number of correct words
var score = 0


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
    var audioPlayer: AVAudioPlayer?
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    
    
    
    
    
    // Begins the game and chooses a new word to display
    @IBAction func startButton(sender: UIButton) {
        blurView.hidden = true
        instructions.hidden = true
        let buttonLabel = sender as UIButton
        
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
            blurView.hidden = false
        }
        updateWords()
        
        print("startButton() has just finished running")
        
    }
    
    
    // This is the function that runs when a word is chosen by the user.
    @IBAction func wordChosen(sender: UIButton) {
        if sender.titleLabel?.text == currentGameWord.correctSpelling {
            print("correct value chosen")
            currentGameWord = chooseWord()
            updateWords()
            currentGameWord.hasBeenUsed = true
            score += 1
            let scoreString = String(score)
            scoreLabel.text = scoreString + " words"
            
            }else{
            lives -= 1
            updateLives()
            print("incorrect value chosen")
           /* commented these out so that the user has to get the correct answer before moving on to the next word
            currentGameWord = chooseWord()
            updateWords() */
            currentGameWord.hasBeenUsed = true
            
            //play wrong answer sound
            let audioFilePath = NSBundle.mainBundle().pathForResource("wrong-sound", ofType: "mp3")
            let fileURL = NSURL(fileURLWithPath: audioFilePath!)
            
            do{
                let audioPlayer = try AVAudioPlayer(contentsOfURL:fileURL)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            }catch {
                print("Error getting the audio file")
            }
    
            if audioPlayer != nil{
                audioPlayer!.play()
            }else{
                
                print("error playing audio")
            }
        }
        
       /* while currentGameWord.hasBeenUsed == true {
            currentGameWord = chooseWord()
        } */
        
        print("wordChosen() has just finished running")
    }
    
    // This function takes the SpellingWord object from chooseWord() and maps it's properties to random bubbles
    func updateWords() {
        //choose a random number between 1 and 3
        let randomNumber = arc4random_uniform(3) + 1
        
        // just for testing
        let randomNumberString = String(randomNumber)
        print("random number: " + randomNumberString)
        
        switch randomNumber{
        case 1:
            wordOneLabel.setTitle(currentGameWord.correctSpelling, forState: UIControlState.Normal)
            wordTwoLabel.setTitle(currentGameWord.incorrectSpelling, forState: UIControlState.Normal)
            wordThreeLabel.setTitle(currentGameWord.altIncorrectSpelling, forState: UIControlState.Normal)
        case 2:
            wordOneLabel.setTitle(currentGameWord.incorrectSpelling, forState: UIControlState.Normal)
            wordTwoLabel.setTitle(currentGameWord.correctSpelling, forState: UIControlState.Normal)
            wordThreeLabel.setTitle(currentGameWord.altIncorrectSpelling, forState: UIControlState.Normal)
        case 3:
            wordOneLabel.setTitle(currentGameWord.incorrectSpelling, forState: UIControlState.Normal)
            wordTwoLabel.setTitle(currentGameWord.altIncorrectSpelling, forState: UIControlState.Normal)
            wordThreeLabel.setTitle(currentGameWord.correctSpelling, forState: UIControlState.Normal)
        default:
            break
        }
        print("updateWords() has just finished running")
        
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
            print("game over")
            //stop the timer somehow
            endGame()
        default:
            break
        }
        
        print("updateLives() has finished running")
        print("\(lives) lives remaining")
    }

    //Ends the current game
    func endGame(){
        print("endGame function just finished running")
        // pauses the timer
        timer.invalidate()
        blurView.hidden = false
        gameOverLabel.hidden = false
        
        

    }
    
    override func viewDidLoad() {
        blurView.hidden = false
        gameOverLabel.hidden = true
        timerLabel.text = "00:00"
        lives = 3
        super.viewDidLoad()
        updateLives()
        //create the words for the dictionary
        let spellAll = SpellingWord(correctSpelling: "all", incorrectSpelling: "al", altIncorrectSpelling: "oll", hasBeenUsed: false)
         let spellGirl = SpellingWord(correctSpelling: "girl", incorrectSpelling: "gurl", altIncorrectSpelling: "jirl", hasBeenUsed: false)
         let spellIf = SpellingWord(correctSpelling: "if", incorrectSpelling: "ef", altIncorrectSpelling: "iff", hasBeenUsed: false)
         let spellOr = SpellingWord(correctSpelling: "or", incorrectSpelling: "ur", altIncorrectSpelling: "orr", hasBeenUsed: false)
         let spellThen = SpellingWord(correctSpelling: "then", incorrectSpelling: "den", altIncorrectSpelling: "thn", hasBeenUsed: false)
         let spellAre = SpellingWord(correctSpelling: "are", incorrectSpelling: "ar", altIncorrectSpelling: "re", hasBeenUsed: false)
         let spellGot = SpellingWord(correctSpelling: "got", incorrectSpelling: "gote", altIncorrectSpelling: "jot", hasBeenUsed: false)
         let spellJump = SpellingWord(correctSpelling: "jump", incorrectSpelling: "gump", altIncorrectSpelling: "jomp", hasBeenUsed: false)
         let spellOut = SpellingWord(correctSpelling: "out", incorrectSpelling: "ot", altIncorrectSpelling: "ote", hasBeenUsed: false)
         let spellThey = SpellingWord(correctSpelling: "they", incorrectSpelling: "dey", altIncorrectSpelling: "thay", hasBeenUsed: false)
         let spellAs = SpellingWord(correctSpelling: "as", incorrectSpelling: "az", altIncorrectSpelling: "ase", hasBeenUsed: false)
         let spellHad = SpellingWord(correctSpelling: "had", incorrectSpelling: "hed", altIncorrectSpelling: "hadd", hasBeenUsed: false)
         let spellLook = SpellingWord(correctSpelling: "look", incorrectSpelling: "lok", altIncorrectSpelling: "looc", hasBeenUsed: false)
         let spellPlay = SpellingWord(correctSpelling: "play", incorrectSpelling: "plae", altIncorrectSpelling: "pla", hasBeenUsed: false)
         let spellThis = SpellingWord(correctSpelling: "this", incorrectSpelling: "dis", altIncorrectSpelling: "thiz", hasBeenUsed: false)
         let spellBe = SpellingWord(correctSpelling: "be", incorrectSpelling: "bea", altIncorrectSpelling: "b", hasBeenUsed: false)
         let spellHas = SpellingWord(correctSpelling: "has", incorrectSpelling: "haz", altIncorrectSpelling: "hes", hasBeenUsed: false)
         let spellMan = SpellingWord(correctSpelling: "man", incorrectSpelling: "mane", altIncorrectSpelling: "mon", hasBeenUsed: false)
        let spellPut = SpellingWord(correctSpelling: "put", incorrectSpelling: "pud", altIncorrectSpelling: "poot", hasBeenUsed: false)
        let spellUs = SpellingWord(correctSpelling: "us", incorrectSpelling: "uz", altIncorrectSpelling: "oz", hasBeenUsed: false)
        let spellBy = SpellingWord(correctSpelling: "by", incorrectSpelling: "bie", altIncorrectSpelling: "bi", hasBeenUsed: false)
        let spellHave = SpellingWord(correctSpelling: "have", incorrectSpelling: "hev", altIncorrectSpelling: "hav", hasBeenUsed: false)
        let spellMom = SpellingWord(correctSpelling: "mom", incorrectSpelling: "mum", altIncorrectSpelling: "mam", hasBeenUsed: false)
         let spellSaid = SpellingWord(correctSpelling: "said", incorrectSpelling: "sed", altIncorrectSpelling: "sid", hasBeenUsed: false)
         let spellWas = SpellingWord(correctSpelling: "was", incorrectSpelling: "wuz", altIncorrectSpelling: "wus", hasBeenUsed: false)
        let spellCome = SpellingWord(correctSpelling: "come", incorrectSpelling: "com", altIncorrectSpelling: "cum", hasBeenUsed: false)
        let spellHer = SpellingWord(correctSpelling: "her", incorrectSpelling: "hur", altIncorrectSpelling: "har", hasBeenUsed: false)
        let spellNot = SpellingWord(correctSpelling: "not", incorrectSpelling: "nott", altIncorrectSpelling: "nout", hasBeenUsed: false)
        let spellSat = SpellingWord(correctSpelling: "sat", incorrectSpelling: "saat", altIncorrectSpelling: "sate", hasBeenUsed: false)
        let spellWay = SpellingWord(correctSpelling: "way", incorrectSpelling: "wuy", altIncorrectSpelling: "wa", hasBeenUsed: false)
        let spellDay = SpellingWord(correctSpelling: "day", incorrectSpelling: "da", altIncorrectSpelling: "dey", hasBeenUsed: false)
        let spellHere = SpellingWord(correctSpelling: "here", incorrectSpelling: "heer", altIncorrectSpelling: "har", hasBeenUsed: false)
        let spellNow = SpellingWord(correctSpelling: "now", incorrectSpelling: "nuw", altIncorrectSpelling: "nouw", hasBeenUsed: false)
        let spellSaw = SpellingWord(correctSpelling: "saw", incorrectSpelling: "sawe", altIncorrectSpelling: "sow", hasBeenUsed: false)
        let spellWent = SpellingWord(correctSpelling: "went", incorrectSpelling: "whent", altIncorrectSpelling: "weant", hasBeenUsed: false)
        let spellDid = SpellingWord(correctSpelling: "did", incorrectSpelling: "dod", altIncorrectSpelling: "dide", hasBeenUsed: false)
        let spellHim = SpellingWord(correctSpelling: "him", incorrectSpelling: "hime", altIncorrectSpelling: "hem", hasBeenUsed: false)
        let spellOf = SpellingWord(correctSpelling: "of", incorrectSpelling: "ov", altIncorrectSpelling: "uf", hasBeenUsed: false)
        let spellSay = SpellingWord(correctSpelling: "say", incorrectSpelling: "sey", altIncorrectSpelling: "sa", hasBeenUsed: false)
        let spellWill = SpellingWord(correctSpelling: "will", incorrectSpelling: "wil", altIncorrectSpelling: "wull", hasBeenUsed: false)
        let spellFor = SpellingWord(correctSpelling: "for", incorrectSpelling: "fer", altIncorrectSpelling: "fore", hasBeenUsed: false)
        let spellHis = SpellingWord(correctSpelling: "his", incorrectSpelling: "hiz", altIncorrectSpelling: "hiss", hasBeenUsed: false)
        let spellOff = SpellingWord(correctSpelling: "off", incorrectSpelling: "uf", altIncorrectSpelling: "aff", hasBeenUsed: false)
        let spellShe = SpellingWord(correctSpelling: "she", incorrectSpelling: "se", altIncorrectSpelling: "che", hasBeenUsed: false)
        let spellWith = SpellingWord(correctSpelling: "with", incorrectSpelling: "wif", altIncorrectSpelling: "wuff", hasBeenUsed: false)
        let spellGet = SpellingWord(correctSpelling: "get", incorrectSpelling: "gat", altIncorrectSpelling: "gete", hasBeenUsed: false)
        let spellHow = SpellingWord(correctSpelling: "how", incorrectSpelling: "huw", altIncorrectSpelling: "hoow", hasBeenUsed: false)
        let spellOne = SpellingWord(correctSpelling: "one", incorrectSpelling: "woon", altIncorrectSpelling: "wun", hasBeenUsed: false)
        let spellSit = SpellingWord(correctSpelling: "sit", incorrectSpelling: "cit", altIncorrectSpelling: "seit", hasBeenUsed: false)
        let spellYes = SpellingWord(correctSpelling: "yes", incorrectSpelling: "wes", altIncorrectSpelling: "yas", hasBeenUsed: false)
        
        // add words to the dictionary
        myDictionaryArray.append(spellAll)
        myDictionaryArray.append(spellGirl)
        myDictionaryArray.append(spellIf)
        myDictionaryArray.append(spellOr)
        myDictionaryArray.append(spellThen)
        myDictionaryArray.append(spellAre)
        myDictionaryArray.append(spellGot)
        myDictionaryArray.append(spellJump)
        myDictionaryArray.append(spellOut)
        myDictionaryArray.append(spellThey)
        myDictionaryArray.append(spellAs)
        myDictionaryArray.append(spellHad)
        myDictionaryArray.append(spellLook)
        myDictionaryArray.append(spellPlay)
        myDictionaryArray.append(spellThis)
        myDictionaryArray.append(spellBe)
        myDictionaryArray.append(spellHas)
        myDictionaryArray.append(spellMan)
        myDictionaryArray.append(spellPut)
        myDictionaryArray.append(spellUs)
        myDictionaryArray.append(spellBy)
        myDictionaryArray.append(spellHave)
        myDictionaryArray.append(spellMom)
        myDictionaryArray.append(spellSaid)
        myDictionaryArray.append(spellWas)
        myDictionaryArray.append(spellCome)
        myDictionaryArray.append(spellHer)
        myDictionaryArray.append(spellNot)
        myDictionaryArray.append(spellSat)
        myDictionaryArray.append(spellWay)
        myDictionaryArray.append(spellDay)
        myDictionaryArray.append(spellHere)
        myDictionaryArray.append(spellNow)
        myDictionaryArray.append(spellSaw)
        myDictionaryArray.append(spellWent)
        myDictionaryArray.append(spellDid)
        myDictionaryArray.append(spellHim)
        myDictionaryArray.append(spellOf)
        myDictionaryArray.append(spellSay)
        myDictionaryArray.append(spellWill)
        myDictionaryArray.append(spellFor)
        myDictionaryArray.append(spellHis)
        myDictionaryArray.append(spellOff)
        myDictionaryArray.append(spellShe)
        myDictionaryArray.append(spellWith)
        myDictionaryArray.append(spellGet)
        myDictionaryArray.append(spellHow)
        myDictionaryArray.append(spellOne)
        myDictionaryArray.append(spellSit)
        myDictionaryArray.append(spellYes)
 
    }

}

