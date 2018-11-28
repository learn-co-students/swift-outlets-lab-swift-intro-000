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
    @IBAction func buttonRed(_ sender: Any) {
        simonSaysGame.guessRed()
        buttonsClicked += 1
        checkWin(buttonClicks: buttonsClicked)
    }
    @IBAction func buttonGreen(_ sender: Any) {
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        checkWin(buttonClicks: buttonsClicked)
    }
    @IBAction func buttonYellow(_ sender: Any) {
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        checkWin(buttonClicks: buttonsClicked)
    }
    @IBAction func buttonBlue(_ sender: Any) {
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        checkWin(buttonClicks: buttonsClicked)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }
    
    func checkWin(buttonClicks: Int) {
        if buttonClicks == 5 {
            if simonSaysGame.wonGame() == true {
                winLabel.text = "You Won!"
                winLabel.isHidden = false
                startGameButton.isHidden = false
                buttonsClicked = 0
            } else {
                winLabel.text = "You Lose!"
                winLabel.isHidden = false
                startGameButton.isHidden = false
                buttonsClicked = 0
            }
        }
    }
    
    func resetSequence() {
        simonSaysGame.patternToMatch.removeAll()
        simonSaysGame.colorToDisplay = 0
        simonSaysGame.chosenColors.removeAll()
        winLabel.text = "Playing"
        
        for _ in (0..<simonSaysGame.numberOfColorsToMatch) {
            let randomNumber = Int(arc4random_uniform(4))
            let randomColor = Color(rawValue: randomNumber)!
            simonSaysGame.patternToMatch.append(randomColor)
        }
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        self.resetSequence()
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.winLabel.isHidden = false
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
                    self.winLabel.text = "Your turn!"
                }
        })
    }
}
