//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    @IBAction func redButton(_ sender: Any) {
        buttonTapped(color: "red")
        buttonsClicked += 1
        endGame()
    }
    @IBAction func greenButton(_ sender: Any) {
        buttonTapped(color: "green")
        buttonsClicked += 1
        endGame()
    }
    @IBAction func yellowButton(_ sender: Any) {
        buttonTapped(color: "yellow")
        buttonsClicked += 1
        endGame()
    }
    
    @IBAction func blueButton(_ sender: Any) {
        buttonTapped(color: "blue")
        buttonsClicked += 1
        endGame()
    }
    
    func buttonTapped(color: String) -> () {
        if color == "red" {
            return simonSaysGame.guessRed()
        }
        if color == "green" {
            return simonSaysGame.guessGreen()
        }
        if color == "yellow" {
            return simonSaysGame.guessYellow()
        }
        if color == "blue" {
            return simonSaysGame.guessBlue()
        }
    }
    
    func endGame() {
        if buttonsClicked == 5 {
            let didWin = simonSaysGame.wonGame()
            if (didWin == true) {
                winLabel.text = "You win!"
                winLabel.isHidden = false
                buttonsClicked = 0
            } else {
                winLabel.text = "Try again."
                winLabel.isHidden = false
                buttonsClicked = 0
            }
        }
    }

    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
            winLabel.isHidden = true
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
