//: Playground - noun: a place where people can play

import UIKit
import Foundation

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
}
// Create the new objects
let spellCat = SpellingWord(correctSpelling: "cat", incorrectSpelling: "catt", altIncorrectSpelling: "kat", hasBeenUsed: false)
let spellJump = SpellingWord(correctSpelling: "jump", incorrectSpelling: "gump", altIncorrectSpelling: "jomp", hasBeenUsed: false)
let spellDog = SpellingWord(correctSpelling: "dog", incorrectSpelling: "dogg", altIncorrectSpelling: "bog", hasBeenUsed: false)
let spellFish = SpellingWord(correctSpelling: "fish", incorrectSpelling: "fesh", altIncorrectSpelling: "fiss", hasBeenUsed: false)



//Set up the dictionary
var myDictionaryArray = [SpellingWord]()

myDictionaryArray.append(spellCat)
myDictionaryArray.append(spellJump)
myDictionaryArray.append(spellDog)
myDictionaryArray.append(spellFish)

print("\(myDictionaryArray.count) items in the Dictionary")



//Select and return a random word from the Dictionary Array
func chooseWord()  -> SpellingWord {
    
    let randomIndex = Int(arc4random_uniform(UInt32(myDictionaryArray.count)))
    let randomItem = myDictionaryArray[randomIndex]
    
    return randomItem
}

var currentGameWord = chooseWord()

while currentGameWord.hasBeenUsed == true {
    currentGameWord = chooseWord()
}

print(currentGameWord.correctSpelling)



// ============== THIS IS ALL THE NEW STUFF ===================//





// Code snippet from user: Nate Cook @ http://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
// ONLY WORKS IN SWIFT 2 (ie. iOS 9+)

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

var wordToShuffle = currentGameWord.correctSpelling
var shuffledWord = Array(wordToShuffle.characters).shuffle()

//Assign index of each character to the proper UIElement.
//Hide or add UIButtons based on length of the word



//FALLBACK FOR SHUFFLE ON iOS 8
/*

func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
let c = count(list)
if c < 2 { return list }
for i in 0..<(c - 1) {
let j = Int(arc4random_uniform(UInt32(c - i))) + i
swap(&list[i], &list[j])
}
return list
}

*/







