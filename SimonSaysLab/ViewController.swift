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
    
    @IBAction func buttonTappedRed(_ sender: UIButton) {
        simonSaysGame.guessRed()
        buttonsClicked+=1
        print(buttonsClicked)
        winLabel.text = "Good so far!, (\(buttonsClicked))"
        winLabel.isHidden = false
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
            checkIfWon()
        }
       
        
    }
    
    @IBAction func buttonTappedGreen(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        buttonsClicked+=1
        print(buttonsClicked)
        winLabel.text = "Good so far!, (\(buttonsClicked))"
        winLabel.isHidden = false
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
            checkIfWon()
        }
        
    }
    
    @IBAction func buttonTappedYellow(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        buttonsClicked+=1
        print(buttonsClicked)
        winLabel.text = "Good so far!, (\(buttonsClicked))"
        winLabel.isHidden = false
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
            checkIfWon()
        }
        
    }
    
    @IBAction func buttonTappedBlue(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        buttonsClicked+=1
        print(buttonsClicked)
        winLabel.text = "Good so far!, (\(buttonsClicked))"
        winLabel.isHidden = false
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
            checkIfWon()
        }
       
    }
    
    func checkIfWon() {
        if simonSaysGame.wonGame() {
            winLabel.isHidden = false
            winLabel.text = "Good Job, You Won!"
        }
        else {
            winLabel.isHidden = false
            winLabel.text = "You Lost, Nice Try!"
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
        
        winLabel.isHidden = true
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
