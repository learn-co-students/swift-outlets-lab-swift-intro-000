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
    var simonSaysGame: SimonSays!
    var gameStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - IBActions
extension ViewController {
    @IBAction func handleRed(_ sender: UIButton) {
        if !gameStarted { return }
        handleAfterGuess(simonSaysGame.guessRed())
    }
    
    @IBAction func handleGreen(_ sender: UIButton) {
        if !gameStarted { return }
        handleAfterGuess(simonSaysGame.guessGreen())
    }
    
    @IBAction func handleYellow(_ sender: UIButton) {
        if !gameStarted { return }
        handleAfterGuess(simonSaysGame.guessYellow())
    }
    
    @IBAction func handleBlue(_ sender: UIButton) {
        if !gameStarted { return }
        handleAfterGuess(simonSaysGame.guessBlue())
    }
}

// MARK: - Other methods
extension ViewController {
    fileprivate func handleAfterGuess(_ correct: Bool) {
        if !correct {
            handleLose()
            return
        } else if simonSaysGame.wonGame() {
            handleWin()
        } else {
            return
        }
    }

    fileprivate func handleLose() {
        winLabel.text = "You lose!"
        gameFinished()
    }
    
    fileprivate func handleWin() {
        winLabel.text = "You win!"
        gameFinished()
    }
    
    fileprivate func gameFinished() {
        winLabel.isHidden = false
        gameStarted = false
        startGameButton.isHidden = false
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        gameStarted = true
        winLabel.isHidden = true
        simonSaysGame = SimonSays()
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
