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
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                self.winLabel.text = "Pattern: \(self.simonSaysGame.patternToMatch)"
            }
        })
    }
    
    func checkWon(){
        winLabel.text = (": \(self.simonSaysGame.chosenColors)")
        self.buttonsClicked = self.buttonsClicked + 1
        if self.simonSaysGame.patternToMatch.count == self.buttonsClicked{
            if self.simonSaysGame.wonGame(){
                winLabel.text = ("You won!")
            }
            else{
                self.buttonsClicked = 0
                
                winLabel.text = ("Nope, try again.")
                self.simonSaysGame.tryAgainWithTheSamePattern()
            }
        }
    }
    
    @IBAction func redTapped(_ sender: UIButton){
        self.simonSaysGame.guessRed()
        
        checkWon()
    }
    
    @IBAction func greenTapped(_ sender: UIButton){
        self.simonSaysGame.guessGreen()
        
        checkWon()
    }

    @IBAction func yellowTapped(_ sender: UIButton){
        self.simonSaysGame.guessYellow()
        
        checkWon()
    }
    
    @IBAction func blueTapped(_ sender: UIButton){
        self.simonSaysGame.guessBlue()
        
        checkWon()
    }
    
}
