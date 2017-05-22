//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func redButton(_ sender: Any) {
        simonSaysGame.guessRed()
        guessed()
    }
    
    @IBAction func greenButton(_ sender: Any) {
        simonSaysGame.guessGreen()
        guessed()
    }
    
    @IBAction func yellowButton(_ sender: Any) {
        simonSaysGame.guessYellow()
        guessed()
    }
    
    @IBAction func blueButton(_ sender: Any) {
        simonSaysGame.guessBlue()
        guessed()
    }
    
    func guessed() {
        buttonsClicked += 1
        
        if buttonsClicked == 5 {
            
            winLabel.isHidden = false
            
            if simonSaysGame.wonGame() {
                winLabel.text = "You Won!"
            } else {
                winLabel.text = "You Lost..."
            }
        }
    }
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    
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
