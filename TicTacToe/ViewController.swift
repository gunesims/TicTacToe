//
//  ViewController.swift
//  TicTacToe
//
//  Created by Crossley Rozario on 9/9/17.
//  Copyright © 2017 Crossley Rozario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func buttonSelect(_ sender: UIButton) {
        
        let buttonSelect = sender as UIButton
        playGame(buttonSelect: buttonSelect)
    }
    
    var ActivePlayer = "X"
    var playerX = [Int]()
    var playerO = [Int]()
    
    var winCombinations = [[0,1,2]]
    
    
    
    func playGame(buttonSelect: UIButton) {
        if ActivePlayer == "X"{
            buttonSelect.setTitle("X", for: UIControlState.normal)
            buttonSelect.setTitleColor(UIColor.cyan, for: .normal)
            playerX.append(buttonSelect.tag)
            ActivePlayer = "O"
            
            
        } else {
            buttonSelect.setTitle("O", for: UIControlState.normal)
            buttonSelect.setTitleColor(UIColor.yellow, for: .normal)
            playerO.append(buttonSelect.tag)
            ActivePlayer = "X"
        }
        buttonSelect.isEnabled = false
    }
    
    func findWinner() {
        
        
        
    
        
    }


    
    
}

