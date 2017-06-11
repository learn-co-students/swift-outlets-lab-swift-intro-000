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
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
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
    
    @IBAction func redButtonTapped(_ sender: UIButton) {
        simonSaysGame.guessRed()
        buttonsClicked += 1
        checkWinConditions()
    }
    
    @IBAction func greenButtonTapped(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        checkWinConditions()
    }
    
    @IBAction func blueButtonTapped(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        checkWinConditions()
    }
    
    @IBAction func yellowButtonTapped(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        checkWinConditions()
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
    
    func checkWinConditions() {
        if buttonsClicked == 5 {
            print("Sequence finished!")
            if simonSaysGame.wonGame() {
                print("Winner !")
                winLabel.text = "You won the game!"
            } else {
                print("Lost")
                winLabel.text = "Error. You lost !"
            }
            winLabel.isHidden = false
        }
    }
}
