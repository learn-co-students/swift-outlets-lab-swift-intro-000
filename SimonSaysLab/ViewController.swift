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
        makeGuess(guess: simonSaysGame.guessRed())

    }
    
    @IBAction func greenButton(_ sender: Any) {
        makeGuess(guess: simonSaysGame.guessGreen())
        
    }
    
    @IBAction func yellowButton(_ sender: Any) {
        makeGuess(guess: simonSaysGame.guessYellow())

    }
    
    @IBAction func blueButton(_ sender: Any) {
        makeGuess(guess: simonSaysGame.guessBlue())

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        winLabel.isHidden = true

    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        simonSaysGame = SimonSays()
        buttonsClicked = 0
        
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        winLabel.isHidden = true
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
    
    fileprivate func makeGuess(guess: Bool) {
        if !guess {
            winLabel.text = "You guessed wrong"
            winLabel.isHidden = false
            simonSaysGame.chosenColors.removeAll()
            simonSaysGame.patternToMatch.removeAll()
            self.startGameButton.isHidden = false
        }
        
        buttonsClicked += 1
        if buttonsClicked >= 5 && guess == true {
            winLabel.text = "You win!"
            winLabel.isHidden = false
            simonSaysGame.chosenColors.removeAll()
            simonSaysGame.patternToMatch.removeAll()
            self.startGameButton.isHidden = false
        }
    }
}
