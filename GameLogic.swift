//
//  GameLogic.swift
//  MasterMind
//
//  Created by Alexi Christakis on 8/17/17.
//  Copyright © 2017 Alexi Christakis. All rights reserved.
//

import Foundation

private var currentGuess = 0

class GameLogic {
    
    func getGuess() -> Int {
        return currentGuess
    }
    
    func updateGuess() {
        currentGuess+=1
        print(currentGuess)
    }
    
    func resetGuess() {
        currentGuess = 0
    }
    
    func decode(guess: [Int]) -> [Int] {
        
        
        var guessColors = Array(repeating: 0, count: 6)
        var blackPegs = 0
        var whitePegs = 0
        
        var code = Code().getCode()
        var codeColors = Code().getCodeColors()
        
        for i in 0..<4 {
            
            if (guess[i] == code[i]) { blackPegs+=1 }
            
            switch (guess[i]) {
            case 0:
                guessColors[0]+=1
            case 1:
                guessColors[1]+=1
            case 2:
                guessColors[2]+=1
            case 3:
                guessColors[3]+=1
            case 4:
                guessColors[4]+=1
            case 5:
                guessColors[5]+=1
            default:
                break
            }
            
        }
        
        for i in 0..<6 {
            if (guessColors[i] <= codeColors[i]) { whitePegs += guessColors[i] }
            if (guessColors[i] > codeColors[i])  { whitePegs += codeColors[i] }
        }
        
        
        
        whitePegs -= blackPegs
        
        return [blackPegs, whitePegs]

    }
    
}
