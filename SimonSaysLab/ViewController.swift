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
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0

    @IBAction func red(_ sender: Any) {
        simonSaysGame.guessRed()
        updateLabel()
    }
    
    @IBAction func green(_ sender: Any) {
        simonSaysGame.guessGreen()
        updateLabel()
    }
    
    @IBAction func yellow(_ sender: Any) {
        simonSaysGame.guessYellow()
        updateLabel()
    }
    
    @IBAction func blue(_ sender: Any) {
        simonSaysGame.guessBlue()
        updateLabel()
    }
    
    func updateLabel() {
        buttonsClicked += 1
        
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
            buttonsClicked = 0
            
            if simonSaysGame.wonGame() {
                winLabel.text = "You won!"
                winLabel.isHidden = false
            }
            else {
                winLabel.text = "Nope, try again."
                winLabel.isHidden = false
            }
        }
    }
   

    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true  //hides won or lost label initially
    }
}

//Testing: click the matching color after the colors flip

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
