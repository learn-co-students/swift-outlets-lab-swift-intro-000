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

        redButton.isEnabled = false
        yellowButton.isEnabled = false
        greenButton.isEnabled = false
        blueButton.isEnabled = false
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        winLabel.isHidden = false
        
        switch sender.tag {
        case 1:
            simonSaysGame.guessRed()
            winLabel.text = "Color \(buttonsClicked + 1): Red"
        case 2:
            simonSaysGame.guessGreen()
            winLabel.text = "Color \(buttonsClicked + 1): Green"
        case 3:
            simonSaysGame.guessYellow()
            winLabel.text = "Color \(buttonsClicked + 1): Yellow"
        case 4:
            simonSaysGame.guessBlue()
            winLabel.text = "Color \(buttonsClicked + 1): Blue"

        default:
            break
        }
        
        buttonsClicked += 1

        if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
            if simonSaysGame.wonGame() {
            winLabel.text = "You win!"
            } else {
                winLabel.text = "Try again"
            }

            simonSaysGame = SimonSays()
            buttonsClicked = 0
            redButton.isEnabled = false
            yellowButton.isEnabled = false
            greenButton.isEnabled = false
            blueButton.isEnabled = false
            startGameButton.isHidden = false
        }
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
        redButton.isEnabled = true
        yellowButton.isEnabled = true
        greenButton.isEnabled = true
        blueButton.isEnabled = true
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
