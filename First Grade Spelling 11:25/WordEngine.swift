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