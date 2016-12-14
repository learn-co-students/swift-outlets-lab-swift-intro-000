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
    var pattern: SimonSays!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winLabel.isHidden = true
        Won()
    }

    @IBAction func redBoxPressed(_ sender: Any) {
        simonSaysGame.guessRed()
    }

    @IBAction func greenBoxPressed(_ sender: Any) {
        simonSaysGame.guessGreen()
    }
    
    @IBAction func yellowBoxPressed(_ sender: Any) {
        simonSaysGame.guessYellow()
    }
    
    @IBAction func blueBoxPressed(_ sender: Any) {
        simonSaysGame.guessBlue()
        
    }
    
    func Won() {
        
        if simonSaysGame.chosenColors == simonSaysGame.patternToMatch {
            
            winLabel.isHidden = false
            winLabel.text = "You won!"
        }
        
        else {
            
            winLabel.isHidden = false
            winLabel.text = "Try again..."
            simonSaysGame.tryAgainWithTheSamePattern()
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
