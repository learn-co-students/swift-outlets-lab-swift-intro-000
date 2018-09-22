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
    
    @IBAction func guessRed(_ sender: UIButton) {
        simonSaysGame.guessRed()
        if simonSaysGame.wonGame() {
            winLabel.isHidden = false
            winLabel.text = "You Won"
        }
    }
    
    @IBAction func guessGreen(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        if simonSaysGame.wonGame() {
            winLabel.isHidden = false
            winLabel.text = "You Won"
        }
    }
    
    @IBAction func guessYellow(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        if simonSaysGame.wonGame() {
            winLabel.isHidden = false
            winLabel.text = "You Won"
        }
    }
    
    @IBAction func guessBlue(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        if simonSaysGame.wonGame() {
            winLabel.isHidden = false
            winLabel.text = "You Won"
        }
    }
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        winLabel.isHidden = true
        super.viewDidLoad()
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
