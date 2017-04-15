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
        
        winLabel.isHidden = false

        
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
    
    
    @IBAction func redTaped(_ sender: UIButton) {
        self.simonSaysGame.guessRed()
        winLabel.text = getGameStatus();
    }
    
    @IBAction func blueTaped(_ sender: UIButton) {
        self.simonSaysGame.guessBlue()
        winLabel.text = getGameStatus();
    }
    
    @IBAction func greenTaped(_ sender: UIButton) {
        self.simonSaysGame.guessGreen()
        winLabel.text = getGameStatus();
    }
    
    @IBAction func yellowTaped(_ sender: UIButton) {
        self.simonSaysGame.guessYellow()
        winLabel.text = getGameStatus();
    }
    
    func getGameStatus() -> String {
        if didfinish() {
            if didGameWin() {
                return "You Won!"
            }
            else {
                self.simonSaysGame.chosenColors.removeAll()
                return "Nope. try again"
            }
        }
        else {
            return "Playing"
        }
    }
    
    
    func didfinish() -> Bool {
        if (self.simonSaysGame.patternToMatch.count == self.simonSaysGame.chosenColors.count) {
            return true
        } else {
            return false
        }
    }
    
    func didGameWin() -> Bool {
            if (self.simonSaysGame.wonGame()) {
                return true
            }
            else {
                return false
            }
    }
    
}
