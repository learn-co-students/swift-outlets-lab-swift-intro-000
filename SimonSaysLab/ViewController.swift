//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var countClicks = 0
    
    
    @IBAction func blueButton(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        checkIfWon()
        
    }
    @IBAction func yellowButton(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        checkIfWon()
    }
    @IBAction func greenButton(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        checkIfWon()
    }
    @IBAction func redButton(_ sender: UIButton) {
        simonSaysGame.guessRed()
        checkIfWon()
    }
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
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
        simonSaysGame.colorToDisplay = 0
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
    
    func checkIfWon() {
        self.countClicks += 1
        winLabel.text = String(countClicks)
        if countClicks >= 5 {
            if simonSaysGame.wonGame() == true {
                winLabel.text = "You won!"
                winLabel.isHidden = false
            } else {
                print("Choosen colors: \(self.simonSaysGame.chosenColors)")
                winLabel.text = "Nope, try again"
                winLabel.isHidden = false
                simonSaysGame.tryAgainWithTheSamePattern()
                self.countClicks = 0
                displayTheColors()
            }
        }
    }
}
