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
    
    // show the result of the game to user
    func checkResult() {
        if buttonsClicked == simonSaysGame.patternToMatch.count {
            if simonSaysGame.wonGame() == true {
                // user won
                winLabel.text = "You won!"
            } else {
                // user lost
                winLabel.text = "Nope, try again."
            }
            winLabel.isHidden = false
            
            // display restart button title: restart
            startGameButton.isHidden = false
        }
    }
    
//    func restartGame () {
//        print("restart game")
//        buttonsClicked = 0
//        winLabel.isHidden = true
//        //simonSaysGame.colorToDisplay = 0
//        self.startGameTapped(startGameButton)
//    
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide winLabel
        winLabel.isHidden = true
    }
    
    // tap red btn
    @IBAction func tapRed(_ sender: Any) {
        print("red was tapped")
        simonSaysGame.guessRed()
        buttonsClicked+=1
        checkResult()
    }
    
    // tap green btn
    @IBAction func tapGreen(_ sender: Any) {
        print("green was tapped")
        simonSaysGame.guessGreen()
        buttonsClicked+=1
        checkResult()
    }
    
    // tap yellow btn
    @IBAction func tapYellow(_ sender: Any) {
        print("yellow was tapped")
        simonSaysGame.guessYellow()
        buttonsClicked+=1
        checkResult()
    }
    
    // tap blue btn
    @IBAction func tapBlue(_ sender: Any) {
        print("blue was tapped")
        simonSaysGame.guessBlue()
        buttonsClicked+=1
        checkResult()
    }
    
    
    
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        print("startGameTapped called")
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
