//
//  MenuViewController.swift
//  MasterMind
//
//  Created by Alexi Christakis on 9/2/17.
//  Copyright © 2017 Alexi Christakis. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBAction func newGame(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        if let boardViewController = destinationViewController as? ViewController {
            if let identifier = segue.identifier {
                
                if identifier == "newGame" { boardViewController.newGame() }
                
            }
        }
        
            
    }
        
        
        
        
    
    
}
