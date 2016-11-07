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
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }

    @IBAction func clickRed(_ sender: UIButton) {
        simonSaysGame.guessRed()
        
        buttonsClicked += 1
        results()
    }
    
    @IBAction func clickGreen(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        
        buttonsClicked += 1
        results()
    }
    
    @IBAction func clickYellow(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        
        buttonsClicked += 1
        results()
    }
    
    @IBAction func clickBlue(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        
        buttonsClicked += 1
        results()
    }
    
    func results() {
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
            if simonSaysGame.wonGame() {
                winLabel.text = "You Won!"
            } else {
                winLabel.text = "You Lost"
            }
            winLabel.isHidden = false
            startGameButton.isHidden = false
            buttonsClicked = 0
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
