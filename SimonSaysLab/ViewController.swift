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
    
    @IBAction func presRed(_ sender: Any) {
        simonSaysGame.guessRed()
        print( "red pressed")
        
       checkGameStatus()
    }
    @IBAction func pressBlue(_ sender: Any) {
        simonSaysGame.guessBlue()
        print ("blue pressed")
        
        checkGameStatus()
    }
    @IBAction func pressYellow(_ sender: Any) {
        simonSaysGame.guessYellow()
        print ("yellow pressed")
        
        checkGameStatus()
    }
    
    @IBAction func pressGreen(_ sender: Any) {
        simonSaysGame.guessGreen()
        print ("green pressed")
        
        checkGameStatus()
    }
    
    func checkGameStatus() {
        if simonSaysGame.wonGame() {
            print("won game")
            winLabel.text = "You Won!"
            winLabel.isHidden = false
            restartGame()
        }  else if simonSaysGame.chosenColors.count == simonSaysGame.numberOfColorsToMatch {
            print ("lost game")
            winLabel.text = "Nope, try again."
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

