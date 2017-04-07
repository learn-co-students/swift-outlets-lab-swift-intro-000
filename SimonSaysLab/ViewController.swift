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
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var yelloButton: UIButton!
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    @IBAction func redButton(_ sender: Any) {
        if simonSaysGame.sequenceFinished() {
            simonSaysGame.guessRed()
            buttonsClicked += 1
        }
        print(simonSaysGame.chosenColors)
        finishedYet()
    }
    @IBAction func greenButton(_ sender: Any) {
        if simonSaysGame.sequenceFinished() {
            simonSaysGame.guessGreen()
            buttonsClicked += 1
        }
        print(simonSaysGame.chosenColors)
        finishedYet()
    }
    @IBAction func yelloButton(_ sender: Any) {
        if simonSaysGame.sequenceFinished() {
            simonSaysGame.guessYellow()
            buttonsClicked += 1
        }
        print(simonSaysGame.chosenColors)
        finishedYet()
    }
    @IBAction func blueButton(_ sender: Any) {
        if simonSaysGame.sequenceFinished() {
            simonSaysGame.guessBlue()
            buttonsClicked += 1
        }
        print(simonSaysGame.chosenColors)
        finishedYet()
    }
    
    func finishedYet() {
        if buttonsClicked == simonSaysGame.patternToMatch.count {
            if simonSaysGame.wonGame() {
                winLabel.text = "You Won!"
            } else {
                winLabel.text = "You Lose!"
            }
            winLabel.isHidden = false
        }
        
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
}
