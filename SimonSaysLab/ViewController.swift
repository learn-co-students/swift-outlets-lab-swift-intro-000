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
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!

    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.winLabel.isHidden = true
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            self.winLabel.isHidden = true
            }, completion: nil)
        buttonsClicked = 0
        displayTheColors()
    }

    @IBAction func redButtonTapped(_ sender: UIButton) {
        if self.view.isUserInteractionEnabled {
            print("red")
            simonSaysGame.guessRed()
            checkGameStatus()
        }
    }

    @IBAction func greenButtonTapped(_ sender: UIButton) {
        if self.view.isUserInteractionEnabled {
            print("green")
            simonSaysGame.guessGreen()
            checkGameStatus()
        }
    }

    @IBAction func yellowButtonTapped(_ sender: UIButton) {
        if self.view.isUserInteractionEnabled {
            print("yellow")
            simonSaysGame.guessYellow()
            checkGameStatus()
        }
    }

    @IBAction func blueButtonTapped(_ sender: UIButton) {
        if self.view.isUserInteractionEnabled {
            print("blue")
            simonSaysGame.guessBlue()
            checkGameStatus()
        }
    }

    fileprivate func checkGameStatus() {
        buttonsClicked += 1
        print("\(buttonsClicked)")
        if (buttonsClicked == simonSaysGame.numberOfColorsToMatch) {
            print("colors matched")
            winLabel.isHidden = false
            startGameButton.isHidden = false
            if (simonSaysGame.wonGame()) {
                winLabel.text = "You have won!"
            } else {
                winLabel.text = "Nope, try again."
            }
        }
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
