//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var Red: UIButton!
    @IBOutlet weak var Green: UIButton!
    @IBOutlet weak var Yellow: UIButton!
    @IBOutlet weak var Blue: UIButton!
    
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    
    override func viewDidLoad() {
        
        winLabel.isHidden = true
        
        super.viewDidLoad()
    }
    
    
    func Gameresult() {
        if (simonSaysGame.chosenColors == simonSaysGame.patternToMatch) {
            if simonSaysGame.wonGame() {
                winLabel.text = "Hurray you've won!"
                winLabel.isHidden = false
                startGameButton.isHidden = false
            }
                
            else {
                winLabel.text = "Ya lost Buddy try again"
                winLabel.isHidden = false
                startGameButton.isHidden = false
                
            }
            
            simonSaysGame = SimonSays()
            winLabel.isHidden = false
            buttonsClicked = 0
            
        }
        else {
            winLabel.text = "Hey bro, only " + String(simonSaysGame.patternToMatch.count - simonSaysGame.chosenColors.count) + " to go"
            winLabel.isHidden = false
        }
    }
    
    @IBAction func CInputs(_ sender: UIButton) {
        buttonsClicked = +1
    
        switch sender{
        case Red: simonSaysGame.guessRed()
        
        case Blue: simonSaysGame.guessBlue()
        
        case Yellow: simonSaysGame.guessYellow()
        
        case Green: simonSaysGame.guessGreen()
        
        default: return
        }
        Gameresult()
    }
    
    
    }




    

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
        winLabel.isHidden = true
        buttonsClicked = 0
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
