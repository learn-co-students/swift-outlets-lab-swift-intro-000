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
    
    @IBAction func redGuessed(_ sender: Any) {
        simonSaysGame.guessRed()
        check()
    }
    
    @IBAction func greenGuessed(_ sender: Any) {
        simonSaysGame.guessGreen()
        check()
    }
    
    @IBAction func yellowGuessed(_ sender: Any) {
        simonSaysGame.guessYellow()
        check()
    }
    
    @IBAction func blueGuessed(_ sender: Any) {
        simonSaysGame.guessBlue()
        check()
    }
    
    func check() {
        if simonSaysGame.chosenColors.count == simonSaysGame.patternToMatch.count {
            var won = simonSaysGame.wonGame()
            if won == true {
                winLabel.text = "You win!!"
                winLabel.isHidden = false
                startGameButton.isHidden = false
            } else {
                winLabel.text = "Try again!"
                winLabel.isHidden = false
                startGameButton.isHidden = false
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
