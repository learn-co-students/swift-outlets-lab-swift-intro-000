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
    
    @IBAction func clickRed(_ sender: Any) {
        simonSaysGame.guessRed()
        checkIfWin()
    }
    
    @IBAction func clickGreen(_ sender: Any) {
        simonSaysGame.guessGreen()
        checkIfWin()
    }
    
    @IBAction func clickYellow(_ sender: Any) {
        simonSaysGame.guessYellow()
        checkIfWin()
    }
    
    @IBAction func clickBlue(_ sender: Any) {
        simonSaysGame.guessBlue()
        checkIfWin()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }
    
    func checkIfWin() {
        if simonSaysGame.patternToMatch.count == simonSaysGame.chosenColors.count && self.simonSaysGame.wonGame() {
            winLabel.text = "You won!"
            self.startGameButton.isHidden = false
        } else if simonSaysGame.patternToMatch.count == simonSaysGame.chosenColors.count && self.simonSaysGame.wonGame() == false {
            winLabel.text = "Nope, try again."
            self.startGameButton.isHidden = false
        }
        else {
            winLabel.isHidden = false
            winLabel.text = "\(simonSaysGame.patternToMatch.count - simonSaysGame.chosenColors.count) move(s) remaining..."
        }
    }
    
    func resetSequence() {
        simonSaysGame.patternToMatch.removeAll()
        simonSaysGame.colorToDisplay = 0
        simonSaysGame.chosenColors.removeAll()
        winLabel.text = "Playing..."
        
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
