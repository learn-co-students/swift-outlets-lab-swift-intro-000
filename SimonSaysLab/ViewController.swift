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
    @IBAction func pushRed(_ sender: Any) {
        simonSaysGame.guessRed()
        print("Red has been selected")
        buttonsClicked += 1
        isGameWon()
    }
    @IBAction func pushGreen(_ sender: Any) {
        simonSaysGame.guessGreen()
        print("Green has been selected")
        buttonsClicked += 1
        isGameWon()
    }
    @IBAction func pushYellow(_ sender: Any) {
        simonSaysGame.guessYellow()
        print("Yellow has been selected")
        buttonsClicked += 1
        isGameWon()
    }
    @IBAction func pushBlue(_ sender: Any) {
        simonSaysGame.guessBlue()
        print("BLUE has been selected")
        buttonsClicked += 1
        isGameWon()
    }
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
    
    func isGameWon () {
        if simonSaysGame.wonGame() == true {
            winLabel.text = "Congratulations, you won!"
            winLabel.isHidden = false
        } else if buttonsClicked == 5 {
            winLabel.text = "Please try again"
            winLabel.isHidden = false
        }
    }
    
}
