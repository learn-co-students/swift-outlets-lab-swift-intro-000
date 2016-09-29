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
        winLabel.isHidden = true
        super.viewDidLoad()
    }
    func winOrLose() {
        if (buttonsClicked == 5) {
            if (simonSaysGame.wonGame()) {
                winLabel.text = "You Won!"
                winLabel.isHidden = false
                startGameButton.isHidden = false
            }
            else {
                winLabel.text = "Try Again"
                winLabel.isHidden = false
            }
        }
    }
    
    @IBAction func redSquare(_ sender: AnyObject) {
        simonSaysGame.guessRed()
        buttonsClicked += 1
        winOrLose()
    }
    @IBAction func blueSquare(_ sender: AnyObject) {
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        winOrLose()
    }
    @IBAction func yellowSquare(_ sender: AnyObject) {
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        winOrLose()
    }
    @IBAction func greenSquare(_ sender: AnyObject) {
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        winOrLose()
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.2, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 0.3, options: .transitionCurlUp, animations: {
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
