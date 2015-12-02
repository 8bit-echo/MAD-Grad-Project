//
//  WordEngine.swift
//  First Grade Spelling
//
//  Created by Matt Dickey on 11/24/15.
//  Copyright (c) 2015 Megan Leahy. All rights reserved.
//

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


func chooseWord()  -> SpellingWord {
    
    let randomIndex = Int(arc4random_uniform(UInt32(myDictionaryArray.count)))
    let randomItem = myDictionaryArray[randomIndex]
    
    return randomItem
}



// Code snippet from user: Nate Cook @ http://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
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


