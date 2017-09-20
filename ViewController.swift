//
//  ViewController.swift
//  MasterMind
//
//  Created by Alexi Christakis on 8/17/17.
//  Copyright © 2017 Alexi Christakis. All rights reserved.
//

import UIKit
import AudioToolbox

func solidToBlur(image: UIImage) -> UIImage {
    switch image {
    case #imageLiteral(resourceName: "red"): return #imageLiteral(resourceName: "blur_red")
    case #imageLiteral(resourceName: "green"): return #imageLiteral(resourceName: "blur_green")
    case #imageLiteral(resourceName: "blue"): return #imageLiteral(resourceName: "blur_blue")
    case #imageLiteral(resourceName: "yellow"): return #imageLiteral(resourceName: "blur_yellow")
    case #imageLiteral(resourceName: "purple"): return #imageLiteral(resourceName: "blur_purple")
    case #imageLiteral(resourceName: "orange"): return #imageLiteral(resourceName: "blur_orange")
    default: return image
    }
}

func blurToSolid(image: UIImage) -> UIImage {
    switch image {
    case #imageLiteral(resourceName: "blur_red"): return #imageLiteral(resourceName: "red")
    case #imageLiteral(resourceName: "blur_green"): return #imageLiteral(resourceName: "green")
    case #imageLiteral(resourceName: "blur_blue"): return #imageLiteral(resourceName: "blue")
    case #imageLiteral(resourceName: "blur_yellow"): return #imageLiteral(resourceName: "yellow")
    case #imageLiteral(resourceName: "blur_purple"): return #imageLiteral(resourceName: "purple")
    case #imageLiteral(resourceName: "blur_orange"): return #imageLiteral(resourceName: "orange")
    default: return image
    }
}

func colorToNumber(image: UIImage) -> Int {
    switch image {
    case #imageLiteral(resourceName: "red"): return 0
    case #imageLiteral(resourceName: "green"): return 1
    case #imageLiteral(resourceName: "blue"): return 2
    case #imageLiteral(resourceName: "yellow"): return 3
    case #imageLiteral(resourceName: "purple"): return 4
    case #imageLiteral(resourceName: "orange"): return 5
    default: return 0
    }
}

func numberToColor(of: Int) -> UIImage {
    switch of {
    case 0: return #imageLiteral(resourceName: "red")
    case 1: return #imageLiteral(resourceName: "green")
    case 2: return #imageLiteral(resourceName: "blue")
    case 3: return #imageLiteral(resourceName: "yellow")
    case 4: return #imageLiteral(resourceName: "purple")
    case 5: return #imageLiteral(resourceName: "orange")
    default: return #imageLiteral(resourceName: "red")
    }
}

class ViewController: UIViewController {
    
    // guess selection buttons
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    // board preview and submitted guesses
    @IBOutlet var boardPreview: [UIImageView]!
    @IBOutlet var responsePegs: [UIImageView]!
    
    // end game screen
    @IBOutlet weak var gameOver: UIView!
    @IBOutlet weak var endGameLabel: UILabel!
    @IBOutlet weak var winLose: UILabel!
    @IBOutlet var secretCode: [UIImageView]!
    @IBAction func newGame(_ sender: UIButton) {
        newGame()
    }
        
    @IBAction func unwindToViewController (sender: UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        newGame()
        
    }
  
    var guess = Array(repeating: 0, count: 4)
    let animationDuration = 0.2
    
    @IBOutlet weak var swipeableView: UIView! {
        didSet {
            let swipeRight = UISwipeGestureRecognizer(
                target: self, action: #selector(handleGesture)
            )
            
            swipeRight.direction = .right
            
            swipeableView.addGestureRecognizer(swipeRight)
        }
    }
    
    func handleGesture() {
        
        if guessComplete() {
            
            let currentGuess = GameLogic().getGuess()
            
            AudioServicesPlaySystemSound(1519)
            
            var response: [Int] = GameLogic().decode(guess: guess)
            
            UIButton.animate(withDuration: animationDuration, animations: {
                self.button0.setBackgroundImage(#imageLiteral(resourceName: "empty_selection_l"), for: UIControlState.normal)
                self.button1.setBackgroundImage(#imageLiteral(resourceName: "empty_selection_l"), for: UIControlState.normal)
                self.button2.setBackgroundImage(#imageLiteral(resourceName: "empty_selection_l"), for: UIControlState.normal)
                self.button3.setBackgroundImage(#imageLiteral(resourceName: "empty_selection_l"), for: UIControlState.normal)
            })
            
            for i in 0..<4 {
                
                let index = i + 4*currentGuess
                let solidColor = blurToSolid(image: boardPreview[index].image!)
                
                UIView.transition(
                    with: boardPreview[index],
                    duration: animationDuration,
                    options: .transitionCrossDissolve,
                    animations: { self.boardPreview[index].image = solidColor },
                    completion: nil
                )
                
            }

            var responseIndex = 0
            for _ in 0..<response[0] {
                responsePegs[responseIndex + 4*currentGuess].image = #imageLiteral(resourceName: "black")
                responseIndex+=1
            }
            
            for _ in 0..<response[1] {
                responsePegs[responseIndex + 4*currentGuess].image = #imageLiteral(resourceName: "white")
                responseIndex+=1
            }
            
            GameLogic().updateGuess()
            
            if (response[0] == 4) { winGame() }
            if (currentGuess == 7) { loseGame(code: Code().getCode()) }
            
        }
        
    }
    
    func guessComplete() -> Bool {
        
        if  button0.currentBackgroundImage == #imageLiteral(resourceName: "empty_selection_l") ||
            button1.currentBackgroundImage == #imageLiteral(resourceName: "empty_selection_l") ||
            button2.currentBackgroundImage == #imageLiteral(resourceName: "empty_selection_l") ||
            button3.currentBackgroundImage == #imageLiteral(resourceName: "empty_selection_l")
            { return false }
        
        return true
    }
    
    @IBAction func colorPick(_ sender: UIButton) {
        
        if sender.currentBackgroundImage == #imageLiteral(resourceName: "empty_selection_l") {
            sender.setBackgroundImage(#imageLiteral(resourceName: "red"), for: UIControlState.normal)
        } else if sender.currentBackgroundImage == #imageLiteral(resourceName: "red") {
            sender.setBackgroundImage(#imageLiteral(resourceName: "green"), for: UIControlState.normal)
        } else if sender.currentBackgroundImage == #imageLiteral(resourceName: "green") {
            sender.setBackgroundImage(#imageLiteral(resourceName: "blue"), for: UIControlState.normal)
        } else if sender.currentBackgroundImage == #imageLiteral(resourceName: "blue") {
            sender.setBackgroundImage(#imageLiteral(resourceName: "yellow"), for: UIControlState.normal)
        } else if sender.currentBackgroundImage == #imageLiteral(resourceName: "yellow") {
            sender.setBackgroundImage(#imageLiteral(resourceName: "purple"), for: UIControlState.normal)
        } else if sender.currentBackgroundImage == #imageLiteral(resourceName: "purple") {
            sender.setBackgroundImage(#imageLiteral(resourceName: "orange"), for: UIControlState.normal)
        } else {
            sender.setBackgroundImage(#imageLiteral(resourceName: "red"), for: UIControlState.normal)
        }
        
        let index = Int(sender.currentTitle!)! + 4*GameLogic().getGuess()
        let color = solidToBlur(image: sender.currentBackgroundImage!)
        
        UIView.transition(
            with: boardPreview[index],
            duration: animationDuration,
            options: .transitionCrossDissolve,
            animations: { self.boardPreview[index].image = color },
            completion: nil
        )
        
        guess[Int(sender.currentTitle!)!] = colorToNumber(image: sender.currentBackgroundImage!)
        
        
    }

    
    func winGame() {
        
        winLose.text = "you win!"
        endGameLabel.text = "you correctly guessed:"
        
        gameOver.isHidden = false
        
        button0.isEnabled = false
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        
    }
    
    func loseGame(code: [Int]) {
        
        winLose.text = "you lose"
        endGameLabel.text = "the code was:"
        
        gameOver.isHidden = false
        
        button0.isEnabled = false
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false

    }
    
    func newGame() {
        
        gameOver.isHidden = true
        
        for i in 0..<32 {
            
            boardPreview[i].image = #imageLiteral(resourceName: "empty_selection_d")
            responsePegs[i].image = #imageLiteral(resourceName: "empty_selection_d")
            
        }
        
        button0.setBackgroundImage(#imageLiteral(resourceName: "empty_selection_l"), for: .normal)
        button1.setBackgroundImage(#imageLiteral(resourceName: "empty_selection_l"), for: .normal)
        button2.setBackgroundImage(#imageLiteral(resourceName: "empty_selection_l"), for: .normal)
        button3.setBackgroundImage(#imageLiteral(resourceName: "empty_selection_l"), for: .normal)
        
        Code().new()
        let code = Code().getCode()
        
        for i in 0..<4 {
            
            secretCode[i].image = numberToColor(of: code[i])

        }
        
        GameLogic().resetGuess()
        
        button0.isEnabled = true
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
                
    }
 
}

