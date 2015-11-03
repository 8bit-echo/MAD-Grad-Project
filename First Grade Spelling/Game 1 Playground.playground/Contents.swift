//: Playground - noun: a place where people can play

import UIKit


var lives = 3
var score = 0

class SpellingWord {
    //This class sets up the structure for the three spellings of the word
    var correctSpelling: String = ""
    var incorrectSpelling: String = ""
    var altIncorrectSpelling : String = ""
    
    //pass a Bool value into the function to determine what happens next.
    func correctWordWasChosen(correct : Bool){
        if correct{
            //Play sound for good
            score = ++score
        }else{
            //Play sound for bad
            lives = lives - 1
        }
    }
}




// Create the new object
let spellCat = SpellingWord()

//Set the Correct Spelling
    spellCat.correctSpelling = "Cat"

//Set the incorrect spellings
    spellCat.incorrectSpelling = "Catt"
    spellCat.altIncorrectSpelling = "kat"

//Toggle b/w true and false to see if user got it right
    spellCat.correctWordWasChosen(false)

//Print results to the console
    println(lives)
    println(score)

// Go ahead and mess around with this if you think it needs changing.


                        // ======  To Do List ===== //
/*

    - Make a dictionary of default words
    - Make a function that will choose a random word from the dictionary
    - Pass the random word into a variable as a new SpellingWord() object
    - Make a new function to end the Game.
    - Make an engine that can auto-generate bad spellings of words ( maybe through a switch / case ?)



*/







