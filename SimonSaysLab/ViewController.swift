//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var guessCount: UILabel!
    @IBOutlet weak var loseLabel: UILabel!
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    var guessCountLeft = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winLabel.isHidden = true
        loseLabel.isHidden = true
    }
    
    
    @IBAction func redButton(_ sender: AnyObject) {
        simonSaysGame.guessRed()
        buttonsClicked+=1
        guessCountLeft = simonSaysGame.patternToMatch.count - buttonsClicked
        guessCount.text = "\(guessCountLeft) Guess Left"
        if buttonsClicked == simonSaysGame.patternToMatch.count {
            guessCount.isHidden = true
            if simonSaysGame.wonGame() {
                winLabel.isHidden = false
            } else {loseLabel.isHidden = false}
            startGameButton.isHidden = false
            self.buttonsClicked = 0
            self.simonSaysGame = SimonSays()
        }
        
    }
    @IBAction func yellowButton(_ sender: AnyObject) {
        simonSaysGame.guessYellow()
        buttonsClicked+=1
        guessCountLeft = simonSaysGame.patternToMatch.count - buttonsClicked
        guessCount.text = "\(guessCountLeft) Guess Left"
        if buttonsClicked == simonSaysGame.patternToMatch.count {
            guessCount.isHidden = true
            if simonSaysGame.wonGame() {
                winLabel.isHidden = false
            } else {loseLabel.isHidden = false}
            startGameButton.isHidden = false
            self.buttonsClicked = 0
            self.simonSaysGame = SimonSays()
        }
        
    }
    @IBAction func greenButton(_ sender: AnyObject) {
        simonSaysGame.guessGreen()
        buttonsClicked+=1
        guessCountLeft = simonSaysGame.patternToMatch.count - buttonsClicked
        guessCount.text = "\(guessCountLeft) Guess Left"
        if buttonsClicked == simonSaysGame.patternToMatch.count {
            guessCount.isHidden = true
            if simonSaysGame.wonGame() {
                winLabel.isHidden = false
            } else {loseLabel.isHidden = false}
            startGameButton.isHidden = false
            self.buttonsClicked = 0
            self.simonSaysGame = SimonSays()
        }
        
    }
    @IBAction func blueButton(_ sender: AnyObject) {
        simonSaysGame.guessBlue()
        buttonsClicked+=1
        guessCountLeft = simonSaysGame.patternToMatch.count - buttonsClicked
        guessCount.text = "\(guessCountLeft) Guess Left"
        if buttonsClicked == simonSaysGame.patternToMatch.count {
            guessCount.isHidden = true
            if simonSaysGame.wonGame() {
                winLabel.isHidden = false
            } else {loseLabel.isHidden = false}
            startGameButton.isHidden = false
            self.buttonsClicked = 0
            self.simonSaysGame = SimonSays()
        }
        
    }
    
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            self.loseLabel.isHidden = true
            self.winLabel.isHidden = true
            }, completion: nil)
        
        displayTheColors()
        guessCount.isHidden = false
        
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    //print("colorToDisplay = \(self.simonSaysGame.colorToDisplay)")
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
