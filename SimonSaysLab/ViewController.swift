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
    var count = 0
    
    @IBAction func yellow(_ sender: Any) {
        simonSaysGame.guessYellow()
        print("yellow pressed")
        count += 1
        checkIfWon()
    }
    
    @IBAction func green(_ sender: Any) {
        simonSaysGame.guessGreen()
        print("green pressed")
        count += 1
        checkIfWon()
    }
    
    @IBAction func red(_ sender: Any) {
        simonSaysGame.guessRed()
        print("red pressed")
        count += 1
        checkIfWon()
    }
    
    @IBAction func blue(_ sender: Any) {
        simonSaysGame.guessBlue()
        print("blue pressed")
        count += 1
        checkIfWon()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }
    
    func checkIfWon() {
        if count > 4 {
            if simonSaysGame.wonGame() {
                winLabel.text = "You've won"
            }
            else {
                winLabel.text = "You've failed"
            }
            winLabel.isHidden = false
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
