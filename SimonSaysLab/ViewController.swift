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
    
    @IBAction func redButton(_ sender: AnyObject) {
        simonSaysGame.guessRed()
        guessMade()
    }
    
    @IBAction func greenButton(_ sender: AnyObject) {
        simonSaysGame.guessGreen()
        guessMade()
    }
    
    @IBAction func yellowButton(_ sender: AnyObject) {
        simonSaysGame.guessYellow()
        guessMade()
    }
    
    @IBAction func blueButton(_ sender: AnyObject) {
        simonSaysGame.guessBlue()
        guessMade()
    }
    
    func guessMade() {
        buttonsClicked += 1
        checkEnd(buttonsClicked)
    }
    
    func checkEnd(_ buttonClicks: Int) {
        if buttonClicks >= 5 {
            if simonSaysGame.wonGame() {
                winLabel.text = "You won!"
            } else {
                simonSaysGame.tryAgainWithTheSamePattern()
                winLabel.text = "You lose!"
            }
            winLabel.isHidden = false
        }
    }
    
    override func viewDidLoad() {
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
