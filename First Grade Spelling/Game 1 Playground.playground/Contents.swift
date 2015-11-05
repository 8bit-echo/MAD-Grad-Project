//: Playground - noun: a place where people can play

import UIKit


var lives = 3
var score = 0

class SpellingWord {
    //This class sets up the structure for the three spellings of the word
    var correctSpelling: String
    var incorrectSpelling: String
    var altIncorrectSpelling : String
    var hasBeenUsed : Bool
    
    init(correctSpelling: String, incorrectSpelling : String, altIncorrectSpelling: String, hasBeenUsed : Bool){
        self.correctSpelling = correctSpelling
        self.incorrectSpelling = incorrectSpelling
        self.altIncorrectSpelling = altIncorrectSpelling
        self.hasBeenUsed = hasBeenUsed
    }
    
    //pass a Bool value into the function to determine what happens next.
    func correctWordWasChosen(correct : Bool){
        if correct{
            //Play sound for good
            score = ++score
            hasBeenUsed = true
        }else{
            //Play sound for bad
            lives = lives - 1
            hasBeenUsed = true
        }
    }
}

// Create the new objects
let spellCat = SpellingWord(correctSpelling: "Cat", incorrectSpelling: "Catt", altIncorrectSpelling: "kat", hasBeenUsed: false)
let spellJump = SpellingWord(correctSpelling: "jump", incorrectSpelling: "gump", altIncorrectSpelling: "jomp", hasBeenUsed: false)
let spellDog = SpellingWord(correctSpelling: "Dog", incorrectSpelling: "dogg", altIncorrectSpelling: "bog", hasBeenUsed: false)
let spellFish = SpellingWord(correctSpelling: "fish", incorrectSpelling: "fesh", altIncorrectSpelling: "fiss", hasBeenUsed: false)


//Set up the dictionary
var myDictionaryArray = [SpellingWord]()

myDictionaryArray.append(spellCat)
myDictionaryArray.append(spellJump)
myDictionaryArray.append(spellDog)
myDictionaryArray.append(spellFish)

println("\(myDictionaryArray.count) items in the Dictionary")



//Select and return a random word from the Dictionary Array
func chooseWord()  -> SpellingWord {
    
    let randomIndex = Int(arc4random_uniform(UInt32(myDictionaryArray.count)))
    let randomItem = myDictionaryArray[randomIndex]
    return randomItem
}


var currentGameWord = chooseWord()


//When it gets to this point it has now chosen a random word from the list and stored it in the variable "currrentGameWord"
//Now we can modify any of its properties or methods based on the user Interface


currentGameWord.correctWordWasChosen(true)



//Print results to the console
print("\(lives) lives remaining.")
print("Score: \(score)")



//Modified by Dick 23:43 Nov 4


                        // ======  To Do List ===== //
/*

    "$" Denotes completion

    $- Make a dictionary of default words
    $- Make a function that will choose a random word from the dictionary
    - Make a new function to end the Game.
    - Make an engine that can auto-generate bad spellings of words ( maybe through a switch / case ?)



*/







