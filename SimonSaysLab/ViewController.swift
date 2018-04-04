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
    
    @IBAction func redButton(_ sender: Any) {
        buttonsClicked += 1
        simonSaysGame.guessRed()
       self.checkGameStatus()
    }
    @IBAction func greenButton(_ sender: Any) {
        buttonsClicked += 1
        simonSaysGame.guessGreen()
        self.checkGameStatus()
    }
    @IBAction func yellowButton(_ sender: Any) {
        buttonsClicked += 1
        simonSaysGame.guessYellow()
        self.checkGameStatus()
    }
    @IBAction func blueButton(_ sender: Any) {
        buttonsClicked += 1
        simonSaysGame.guessBlue()
        self.checkGameStatus()
    }
    
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
    
    fileprivate func checkGameStatus() {
        if buttonsClicked >= simonSaysGame.patternToMatch.count {
            
            winLabel.isHidden = false
            if simonSaysGame.wonGame() {
                winLabel.text = "You won!"
            } else {
                winLabel.text = "Nope, try again."
            }
        }

    }
}
