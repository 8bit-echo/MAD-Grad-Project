//
//  WordEngine.swift
//  First Grade Spelling
//
//  Created by Megan Leahy on 11/6/15.
//  Copyright (c) 2015 Megan Leahy. All rights reserved.
//

import Foundation

var lives = 3
var score = 0

class SpellingWord: NSObject {
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
    
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(correctSpelling, forKey:"correctSpelling")
        aCoder.encodeObject(incorrectSpelling, forKey:"incorrectSpelling")
        aCoder.encodeObject(altIncorrectSpelling, forKey:"incorrectSpelling")
    }
    
    init (coder aDecoder: NSCoder!) {
        self.correctSpelling = aDecoder.decodeObjectForKey("correctSpelling") as! String
        self.incorrectSpelling = aDecoder.decodeObjectForKey("incorrectSpelling") as! String
        self.altIncorrectSpelling = aDecoder.decodeObjectForKey("altIncorrectSpelling") as! String
        self.hasBeenUsed = aDecoder.decodeObjectForKey("hasBeenUsed") as! Bool
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

