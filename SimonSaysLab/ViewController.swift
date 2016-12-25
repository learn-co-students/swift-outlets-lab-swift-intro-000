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
    
    func buttonClicked() {
        buttonsClicked = buttonsClicked + 1
        
        if buttonsClicked == 5 {
            switch simonSaysGame.wonGame() {
            case true:
                winLabel.text = "You won!"
            case false:
                winLabel.text = "Nope, try again"
            }
            winLabel.isHidden = false
        }
    }
    
    @IBAction func buttonRed(_ sender: UIButton) {
        simonSaysGame.guessRed()
        buttonClicked()
    }
    
    @IBAction func buttonGreen(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        buttonClicked()
    }
    
    @IBAction func buttonYellow(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        buttonClicked()
    }
    
    @IBAction func buttonBlue(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        buttonClicked()
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
}
