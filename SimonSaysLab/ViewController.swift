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
    
    @IBAction func redPressed(_ sender: Any) {
        buttonsClicked += 1
        simonSaysGame.guessRed()
        determineWin()
    }
    
    @IBAction func greenPressed(_ sender: Any) {
        buttonsClicked += 1
        simonSaysGame.guessGreen()
        determineWin()
    }
    
    @IBAction func yellowPressed(_ sender: Any) {
        buttonsClicked += 1
        simonSaysGame.guessYellow()
        determineWin()
    }
    
    @IBAction func bluePressed(_ sender: Any) {
        buttonsClicked += 1
        simonSaysGame.guessBlue()
        determineWin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.text = ""
    }
    
    func determineWin() {
        if buttonsClicked >= 5 {
            if simonSaysGame.wonGame() {
                self.winLabel.text = "You won!"
            } else {
                self.winLabel.text = "You lost!"
            }
        }
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
