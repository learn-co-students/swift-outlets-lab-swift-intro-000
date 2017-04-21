//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cubeRed: UIView!
    @IBOutlet weak var cubeGreen: UIView!
    @IBOutlet weak var cubeYel: UIView!
    @IBOutlet weak var cubeBlu: UIView!
    
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    
    @IBAction func redPress(_ sender: UIButton) {
        simonSaysGame.guessRed()
        print("Red ")
        hasWon()
    }
    
    @IBAction func grnPress(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        print("Green ")
        hasWon()
    }
    
    @IBAction func yelPress(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        print("Yellow ")
        hasWon()
    }
    
    @IBAction func bluPress(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        print("Blue ")
        hasWon()
    }
    
    func hasWon() {
        buttonsClicked += 1
        if buttonsClicked >= simonSaysGame.numberOfColorsToMatch {
            if simonSaysGame.wonGame() {
                winLabel.isHidden = false
                winLabel.text = "You won!"
            } else {
                winLabel.isHidden = false
                winLabel.text = "Nope, try again..."
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
        
        winLabel.isHidden = false

        
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
