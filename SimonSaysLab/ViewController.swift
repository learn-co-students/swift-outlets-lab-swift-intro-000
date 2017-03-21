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

    @IBAction func pressRed(_ sender: Any) {
        if buttonsClicked < 5 {
            buttonsClicked += 1
            simonSaysGame.guessRed()
            checkWin()
        }
    }
    
    @IBAction func pressGreen(_ sender: Any) {
        if buttonsClicked < 5 {
            buttonsClicked += 1
            simonSaysGame.guessGreen()
            checkWin()
        }
    }
    
    @IBAction func pressYellow(_ sender: Any) {
        if buttonsClicked < 5 {
            buttonsClicked += 1
            simonSaysGame.guessYellow()
            checkWin()
        }
    }
    
    @IBAction func pressBlue(_ sender: Any) {
        if buttonsClicked < 5 {
            buttonsClicked += 1
            simonSaysGame.guessBlue()
            checkWin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkWin() {
        print(buttonsClicked)
        if buttonsClicked == 5 {
            buttonsClicked = 0
            if simonSaysGame.wonGame() == true {
                winLabel.text = "Congrats!"
             } else {
                winLabel.text = "Try Again!"
            }
            // reset to allow playing again
            startGameButton.isHidden = false
        }
    }
}


// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        simonSaysGame = SimonSays()
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
                    self.buttonsClicked = 0
                }
        })
    }
}
