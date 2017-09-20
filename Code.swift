//
//  Code.swift
//  MasterMind
//
//  Created by Alexi Christakis on 9/2/17.
//  Copyright © 2017 Alexi Christakis. All rights reserved.
//

import Foundation

private var code: [Int]?
private var codeColors: [Int]?

class Code {
    
    
    func new() {
        
        code = [Int(arc4random_uniform(6)),
                Int(arc4random_uniform(6)),
                Int(arc4random_uniform(6)),
                Int(arc4random_uniform(6))]
        
        var count = Array(repeating: 0, count: 6)
        
        for i in 0..<4 {
            
            switch (code![i]) {
            case 0:
                count[0]+=1
            case 1:
                count[1]+=1
            case 2:
                count[2]+=1
            case 3:
                count[3]+=1
            case 4:
                count[4]+=1
            case 5:
                count[5]+=1
            default:
                break
            }
            
        }
        codeColors = count
             
    }
    
    
    func setCode(newCode: [Int]) {
        code = newCode
    }
    
    func getCode() -> [Int] {
        return code!
    }
    
    func getCodeColors() -> [Int] {
        return codeColors!
    }
    
}

