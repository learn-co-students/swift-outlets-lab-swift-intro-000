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
    var buttonsClicked = 1
    
    @IBAction func redB(_ sender: Any) {
        print("Pressed RedB")
        buttonsClicked += 1
        simonSaysGame.guessRed()
        if simonSaysGame.sequenceFinished() == true {
            if buttonsClicked == simonSaysGame.colorToDisplay{
            if simonSaysGame.wonGame(){
                winLabel.text = "Ya did it"
                UIView.transition(with: winLabel, duration: 0.5, options: .transitionCrossDissolve , animations: {self.winLabel.isHidden = false})
            }
            else if simonSaysGame.wonGame() == false {
                winLabel.text = "Ya lost"
                UIView.transition(with: winLabel, duration: 0.5, options: .transitionCrossDissolve , animations: {self.winLabel.isHidden = false})
            }
        }
        }
    }
    @IBAction func blueB(_ sender: Any) {
        print("Pressed BlueB")
        buttonsClicked += 1
        simonSaysGame.guessBlue()
        if simonSaysGame.sequenceFinished() == true {
            if buttonsClicked == simonSaysGame.colorToDisplay{
                if simonSaysGame.wonGame(){
                    winLabel.text = "Ya did it"
                    UIView.transition(with: winLabel, duration: 0.5, options: .transitionCrossDissolve , animations: {self.winLabel.isHidden = false})
                }
                else if simonSaysGame.wonGame() == false {
                    winLabel.text = "Ya lost"
                   UIView.transition(with: winLabel, duration: 0.5, options: .transitionCrossDissolve , animations: {self.winLabel.isHidden = false})
                }
            }
        }
    }
    @IBAction func greenB(_ sender: Any) {
        print("Pressed GreenB")
        buttonsClicked += 1
        simonSaysGame.guessGreen()
        if simonSaysGame.sequenceFinished() == true {
            if buttonsClicked == simonSaysGame.colorToDisplay{
                if simonSaysGame.wonGame(){
                    winLabel.text = "Ya did it"
                    UIView.transition(with: winLabel, duration: 0.5, options: .transitionCrossDissolve , animations: {self.winLabel.isHidden = false})
                }
                else if simonSaysGame.wonGame() == false {
                    winLabel.text = "Ya lost"
                   UIView.transition(with: winLabel, duration: 0.5, options: .transitionCrossDissolve , animations: {self.winLabel.isHidden = false})
                }
            }
        }
    }
    @IBAction func yellowB(_ sender: Any) {
        print("Pressed YellowB")
        buttonsClicked += 1
        simonSaysGame.guessYellow()
        if simonSaysGame.sequenceFinished() == true {
            if buttonsClicked == simonSaysGame.colorToDisplay{
                if simonSaysGame.wonGame(){
                    winLabel.text = "Ya did it"
                    UIView.transition(with: winLabel, duration: 0.5, options: .transitionCrossDissolve , animations: {self.winLabel.isHidden = false})
                }
                else if simonSaysGame.wonGame() == false {
                    winLabel.text = "Ya lost"
                    UIView.transition(with: winLabel, duration: 0.5, options: .transitionCrossDissolve , animations: {self.winLabel.isHidden = false})
                }
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
        UIView.transition(with: displayColorView, duration: 0.7, options: .transitionCurlUp, animations: {
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
