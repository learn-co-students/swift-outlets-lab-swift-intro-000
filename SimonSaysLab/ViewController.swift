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
        super.viewDidLoad()
        winLabel.isHidden = true
    }
    
    
    func checkIfWon()
    {
        if simonSaysGame.wonGame()
        {
            winLabel.text = "You Won"
            winLabel.isHidden = false
        }
        else
        {
            winLabel.text = "You Lost"
            winLabel.isHidden = false
        }
    }
    
    func checkIfCompletedEnteringGuess() -> Bool
    {
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch
        {
            return true
        }
        else
        {
            return false
        }
    }
  
    @IBAction func redPressed(_ sender: Any) {
        
        simonSaysGame.guessRed()
        buttonsClicked += 1
        print("red")
        if checkIfCompletedEnteringGuess()
        {
            checkIfWon()
        }
    }
    
    @IBAction func greenPressed(_ sender: Any) {
        
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        
        print("green")

        if checkIfCompletedEnteringGuess()
        {
            if checkIfCompletedEnteringGuess()
            {
                checkIfWon()
            }
        }
    }
    @IBAction func yellowPressed(_ sender: Any) {
        
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        
        print("yellow")

        if checkIfCompletedEnteringGuess()
        {
            if checkIfCompletedEnteringGuess()
            {
                checkIfWon()
            }
        }
    }
    
    @IBAction func bluePressed(_ sender: Any) {
        
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        print("blue")

        if checkIfCompletedEnteringGuess()
        {
            if checkIfCompletedEnteringGuess()
            {
                checkIfWon()
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
