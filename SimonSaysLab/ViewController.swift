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
    
    @IBAction func redSquare(_ sender: Any) {
        winLabel.isHidden = false
        simonSaysGame.guessRed()
        buttonsClicked += 1
        game()
    }
    @IBAction func greenSquare(_ sender: Any) {
        winLabel.isHidden = false
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        game()
    }
    @IBAction func yellowSquare(_ sender: Any) {
        winLabel.isHidden = false
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        game()
    }
    @IBAction func blueSquare(_ sender: Any) {
        winLabel.isHidden = false
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        game()
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
    
    func game() {
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
            if simonSaysGame.wonGame() == true {
                winLabel.text = "You won!"
                winLabel.isHidden = false
            } else {
                winLabel.text = "Nope, try again."
                winLabel.isHidden = false
                simonSaysGame.tryAgainWithTheSamePattern()
                buttonsClicked = 0
                simonSaysGame.chosenColors.removeAll()
            }
        }
    }
}
