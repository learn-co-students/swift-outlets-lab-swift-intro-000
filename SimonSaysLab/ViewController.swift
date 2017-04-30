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
    
    @IBAction func redButton(_ sender: UIButton) {
        simonSaysGame.guessRed()
        print("red")
        buttonsClicked += 1
        checkIfWin(buttonsClicked)
    }
    
    @IBAction func greenButton(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        print("green")
        buttonsClicked += 1
        checkIfWin(buttonsClicked)
    }
    
    @IBAction func yellowButton(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        print("yellow")
        buttonsClicked += 1
        checkIfWin(buttonsClicked)
    }
    
    @IBAction func blueButton(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        print("blue")
        buttonsClicked += 1
        checkIfWin(buttonsClicked)
    }
    
    func checkIfWin(_ counter: Int) {
        if counter >= 5 {
            winLabel.isHidden = false
            if simonSaysGame.wonGame() {
                winLabel.text = "You won!"
            } else {
                winLabel.text = "Nope, try again!"
            }
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
