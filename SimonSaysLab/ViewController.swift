//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func guessRed(_ sender: AnyObject) {
        if simonSaysGame.guessRed() {
            buttonsClicked += 1
            print(buttonsClicked)
            winLabel.text = "Good so far!"
            winLabel.isHidden = false
            if buttonsClicked == (simonSaysGame.numberOfColorsToMatch) {
                checkIfWon()
            }
        } else {
            checkIfWon()
        }

    }
    @IBAction func guessGreen(_ sender: AnyObject) {
        if simonSaysGame.guessGreen() {
            buttonsClicked += 1
            print(buttonsClicked)
            winLabel.text = "Good so far!"
            winLabel.isHidden = false
            if buttonsClicked == (simonSaysGame.numberOfColorsToMatch) {
                checkIfWon()
            }
        } else {
                checkIfWon()
        }

    }
    @IBAction func guessYellow(_ sender: AnyObject) {
        if simonSaysGame.guessYellow() {
            buttonsClicked += 1
            print(buttonsClicked)
            winLabel.text = "Good so far!"
            winLabel.isHidden = false
            if buttonsClicked == (simonSaysGame.numberOfColorsToMatch) {
                checkIfWon()
            }
        } else {
            checkIfWon()
        }

    }
    @IBAction func guessBlue(_ sender: AnyObject) {
        if simonSaysGame.guessBlue() {
            buttonsClicked += 1
            print(buttonsClicked)
            winLabel.text = "Good so far!"
            winLabel.isHidden = false
            if buttonsClicked == (simonSaysGame.numberOfColorsToMatch) {
                checkIfWon()
            }
        } else {
            
        }
    }
    
    func checkIfWon() {
        if simonSaysGame.wonGame() {
            winLabel.isHidden = false
            winLabel.text = "Good Job! You won!"
        } else {
            winLabel.isHidden = false
            winLabel.text = "Try again!"
        }
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
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1, options: .transitionCurlUp, animations: {
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
