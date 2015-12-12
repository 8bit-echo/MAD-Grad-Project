//
//  ThirdViewController.swift
//  First Grade Spelling
//
//  Created by Megan Leahy on 10/18/15.
//  Copyright (c) 2015 Megan Leahy. All rights reserved.
//

import UIKit
import AVFoundation

var myDictionaryArray3 = [SpellingWord]()

//stores the current word being displayed in the bubbles
var currentGame3Word = chooseWord()

//stores the number of lives
var lives3 = 3

//stores the number of correct words
var score3 = 0
var scoreString3: String = ""

class ThirdViewController: UIViewController, UITextFieldDelegate {
    
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var startTimeDate = NSDate()
    var elapsedTime = NSTimeInterval()
    var elapsedTimeDate = NSDate()
    
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var correctImage: UIImageView!
    @IBOutlet weak var life1: UIImageView!
    @IBOutlet weak var life2: UIImageView!
    @IBOutlet weak var life3: UIImageView!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var instructions: UITextView!
    @IBOutlet weak var gameOverHideView: UIView!
    @IBOutlet weak var startIcon: UIButton!
    
    @IBOutlet weak var userGuesses: UILabel!
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")

    @IBAction func playAudioButton(sender: UIButton) {
        myUtterance = AVSpeechUtterance(string: currentGame3Word.correctSpelling)
        myUtterance.rate = 0.2
        synth.speakUtterance(myUtterance)
    }
    
   
    @IBOutlet weak var userEnteredWord: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkAnswer()
    }
    
    func checkAnswer(){
        if userEnteredWord.text == currentGame3Word.correctSpelling {
            print("correct answer")
            currentGame3Word.hasBeenUsed = true
            correctImage.hidden = false
            score3 += 1
            scoreString3 = String(score3)
            scoreLabel.text = scoreString3 + " words"
            userEnteredWord.text = ""
            userGuesses.hidden = true
            
        } else {
            print("inncorrect answer")
            lives3 -= 1
            updateLives()
            currentGame3Word.hasBeenUsed = true
            //play wrong answer sound
            do{
                self.audioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrong-sound", ofType: "mp3")!))
                self.audioPlayer!.play()
            }catch {
                print("Error getting the audio file")
            }
            userGuesses.hidden = false
            userGuesses.text = "You guessed: " + userEnteredWord.text! + ". Try again!"
        }
    }
    
    @IBAction func nextButton(sender: UIButton) {
        chooseWord() // this isn't working to choose another word
        currentGame3Word = chooseWord()
        correctImage.hidden = true
        print("next button just finished running")
    }
    
    @IBAction func startButton(sender: UIButton) {
        hideView.hidden = true
        instructions.hidden = true
        let buttonLabel = sender as UIButton
        
        if !timer.valid {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTimeDate = NSDate()
            startTime = NSDate.timeIntervalSinceReferenceDate() + elapsedTime
            buttonLabel.setTitle("Pause", forState: UIControlState.Normal)
            
            // start the game
            
        } else {
            buttonLabel.setTitle("Play", forState: UIControlState.Normal)
            elapsedTime += startTimeDate.timeIntervalSinceNow
            timer.invalidate()
            
            // pause the game
           hideView.hidden = false
        }
        print("startButton() has just finished running")
    }

    
    
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
        switch lives3{
            
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
        print("\(lives3) lives remaining")
    }
    
    //Ends the current game
    func endGame(){
        print("endGame function just finished running")
        // pauses the timer
        timer.invalidate()
        gameOverHideView.hidden = false
    }
    
    @IBAction func playAgainButton(sender: UIButton) {
        viewDidLoad()
        score3 = 0
        scoreString3 = String(score3)
        scoreLabel.text = scoreString3 + " words"
        startIcon.setTitle("Start", forState: UIControlState.Normal)
    }
    
    
    override func viewDidLoad() {
        userEnteredWord.delegate = self
        userGuesses.text = ""
        userEnteredWord.text = ""
        gameOverHideView.hidden = true
        hideView.hidden = false
        timerLabel.text = "00:00"
        lives3 = 3
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
