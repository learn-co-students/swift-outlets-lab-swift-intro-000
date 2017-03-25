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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }
   
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        winLabel.isHidden = true
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    func determineMatch() {
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
            if simonSaysGame.wonGame() {
                winLabel.text = "You won!"
                startGameButton.isHidden = false
                buttonsClicked = 0
                simonSaysGame = SimonSays()
            } else {
                winLabel.text = "Nope, try again."
                buttonsClicked = 0
                simonSaysGame.tryAgainWithTheSamePattern()
                displayTheColors()
            }
            
            winLabel.isHidden = false
        }
    }
    
    @IBAction func pressRedButton(_ sender: Any) {
        print("Pressed Red")
        simonSaysGame.guessRed()
        buttonsClicked += 1
        determineMatch()
    }
    
    @IBAction func pressGreenButton(_ sender: Any) {
        print("Pressed Green")
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        determineMatch()
    }
    
    @IBAction func pressYellowButton(_ sender: Any) {
        print("Pressed Yellow")
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        determineMatch()
    }
    
    @IBAction func pressBlueButton(_ sender: Any) {
        print("Pressed Blue")
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        determineMatch()
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
