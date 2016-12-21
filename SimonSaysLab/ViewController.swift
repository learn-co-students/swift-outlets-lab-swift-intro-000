//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        buttonsClicked = buttonsClicked + 1

        
        switch sender {
        case redButton: simonSaysGame.guessRed()
        case greenButton: simonSaysGame.guessGreen()
        case yellowButton: simonSaysGame.guessYellow()
        case blueButton: simonSaysGame.guessBlue()
        default: return
        }
        
        updateWinner()
    }
    
    func updateWinner() {
        if simonSaysGame.chosenColors.count == simonSaysGame.patternToMatch.count {
            print(simonSaysGame.chosenColors)
            if simonSaysGame.wonGame() {
                winLabel.text = "You won"
            } else {
                winLabel.text = "You lost"
            }
            winLabel.isHidden = false
            startGameButton.isHidden = false
            buttonsClicked = 0
            simonSaysGame = SimonSays()
            
            
        } else {
            winLabel.text = "Select " + String(simonSaysGame.patternToMatch.count - simonSaysGame.chosenColors.count) + " more colours"
            winLabel.isHidden = false
        }
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        startGameButton.isHidden = true
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
