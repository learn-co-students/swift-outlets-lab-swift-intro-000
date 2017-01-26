//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var redBox: UIView!
    @IBOutlet weak var greenBox: UIView!
    @IBOutlet weak var yellowBox: UIView!
    @IBOutlet weak var blueBox: UIView!
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winLabel.isHidden = true
    }
    @IBAction func buttonClicked(_ sender: UIButton) {
        buttonsClicked += 1
        
        switch sender {
        case redBox:
            simonSaysGame.guessRed()
        case greenBox:
            simonSaysGame.guessGreen()
        case yellowBox:
            simonSaysGame.guessYellow()
        case blueBox:
            simonSaysGame.guessBlue()
        default:
            return
        }
        
        checkForWinner()
    }
    
    func checkForWinner() {
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
            if simonSaysGame.wonGame() {
                winLabel.text = "Congratulations"
            } else {
                winLabel.text = "Sorry - that's not correct"
            }
            simonSaysGame = SimonSays()
            buttonsClicked = 0
            startGameButton.isHidden = false
        } else {
            winLabel.text = "\(simonSaysGame.numberOfColorsToMatch - buttonsClicked) guess to go..."
        }
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        winLabel.isHidden = false
        winLabel.text = "Choosing colors..."
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
                    
                    self.checkForWinner()
                }
        })
    }
}
