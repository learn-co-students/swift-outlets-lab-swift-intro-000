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
    
    @IBAction func redBtn(_ sender: Any) {
        simonSaysGame.guessRed()
        checkGameStatus()
    }
    @IBAction func blueBtn(_ sender: Any) {
        simonSaysGame.guessBlue()
        checkGameStatus()
    }
    @IBAction func yellowBtn(_ sender: Any) {
        simonSaysGame.guessYellow()
        checkGameStatus()
    }
    @IBAction func greenBtn(_ sender: Any) {
        simonSaysGame.guessGreen()
        checkGameStatus()
    }

    
    func checkGameStatus() {
        if simonSaysGame.wonGame() {
            print("Won Game")
            winLabel.text = "You Win!"
            winLabel.isHidden = false
            restartGame()
        } else if simonSaysGame.chosenColors.count == simonSaysGame.numberOfColorsToMatch {
            print("lost game")
            winLabel.text = "You lost"
            winLabel.isHidden = false
            restartGame()
        }
    }
    
    func restartGame() {
        simonSaysGame = SimonSays()
        startGameButton.isHidden = false
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
