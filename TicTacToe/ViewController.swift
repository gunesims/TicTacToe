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
    }

    @IBOutlet weak var winnerLabel: UILabel!

    @IBAction func buttonSelect(but sender: UIButton) {
        playGame(buttonSelect: sender)
        
        
        
        
    }
    
    var activePlayer = "X"
    var winnerFound = false
    var playerX = [Int]()
    var playerO = [Int]()
    

    
    var winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    
    func searchWinner() {
        for arr in winningCombinations {
            var countX = 0
            var countO = 0
            for i in arr {
                if !playerX.isEmpty && playerX.contains(i) {
                    countX+=1
                }
                if !playerO.isEmpty && playerO.contains(i) {
                    countO+=1
                }
                if countX == 3 {
                    winnerLabel.text?.append("X")
//                    let title = "X won the game"
//                    let message = "Ok"
//                    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: title, style: .default, handler: nil)
//                    ac.addAction(okAction)
                    
                }
                if countO == 3 {
                    winnerLabel.text?.append("O")
                }
            }
        }
        
    }
    
    func resetBoard() {
        
        
    }
    
    
    func playGame(buttonSelect: UIButton) {
        if activePlayer == "X"{
            buttonSelect.setTitle("X", for: UIControlState.normal)
            buttonSelect.setTitleColor(UIColor.cyan, for: .normal)
            playerX.append(buttonSelect.tag)
            searchWinner()
            activePlayer = "O"
            
            
        } else {
            buttonSelect.setTitle("O", for: UIControlState.normal)
            buttonSelect.setTitleColor(UIColor.yellow, for: .normal)
            playerO.append(buttonSelect.tag)
            searchWinner()
            activePlayer = "X"
        }
        buttonSelect.isEnabled = false
    }
    
    
}

