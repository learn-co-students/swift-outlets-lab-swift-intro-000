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
        winLabel.isHidden = true
        //Make buttons uncliackable except start game button
        redButton.isEnabled = false
        greenButton.isEnabled = false
        yellowButton.isEnabled = false
        blueButton.isEnabled = false
    }
    
    @IBAction func pressedRed(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.redButton.alpha = 0.6
            self.redButton.alpha = 1.0
            
        }, completion: nil)
        
        print("Pressed red")
        simonSaysGame.guessRed()
        buttonsClicked += 1
        checkResult()
    }
    @IBAction func pressedGreen(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.greenButton.alpha = 0.6
            self.greenButton.alpha = 1.0
            
        }, completion: nil)

        
        print("Pressed green")
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        checkResult()
    }
    @IBAction func pressedYellow(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.yellowButton.alpha = 0.6
            self.yellowButton.alpha = 1.0
            
        }, completion: nil)

        
        print("Pressed yellow")
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        checkResult()
    }
    @IBAction func pressedBlue(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.blueButton.alpha = 0.6
            self.blueButton.alpha = 1.0
            
        }, completion: nil)

        
        print("Pressed blue")
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        checkResult()
    }
    
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        restart()
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
                    //Make buttons clickable
                    self.redButton.isEnabled = true
                    self.greenButton.isEnabled = true
                    self.yellowButton.isEnabled = true
                    self.blueButton.isEnabled = true
                }
        })
    }
    
    func checkResult() {
        
        //Check if 5 buttons are clicked, if yes then game is over
        if (self.buttonsClicked == self.simonSaysGame.patternToMatch.count) {
            
            print("Game is over")
            
            makeButtonsUnclickable()
            
            //Check if player won the game
            if (self.simonSaysGame.wonGame()) {
                print("You won")
                self.winLabel.text = "You won!"
                self.startGameButton.setTitle("Play Again", for: .normal) //Change start game button text
            }
            else {
                print("You lost")
                self.winLabel.text = "You lost!"
                self.startGameButton.setTitle("Try Again", for: .normal) //Change start game button text
            }
            
            self.winLabel.isHidden = false
            self.startGameButton.isHidden = false
            
        }
        
    }
    
    func restart() {
        
        self.simonSaysGame = SimonSays()
        self.buttonsClicked = 0
        self.winLabel.isHidden = true
        
    }
    
    func makeButtonsUnclickable() {
        
        //Make buttons uncliackable except start game button
        self.redButton.isEnabled = false
        self.greenButton.isEnabled = false
        self.yellowButton.isEnabled = false
        self.blueButton.isEnabled = false
        
    }
    
    
}
