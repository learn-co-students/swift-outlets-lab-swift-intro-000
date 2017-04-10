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
    
    @IBAction func redButton(_ sender: Any) {
        buttonsClicked += 1
        let guess = simonSaysGame.guessRed()
        let win = simonSaysGame.wonGame()
        
        if !guess {
            winLabel.text = "Nope, Try Again."
            winLabel.isHidden = false
            startGameButton.isHidden = false
            if self.buttonsClicked > 0{
                simonSaysGame = SimonSays()
            }
        }
        if win{
            winLabel.text = "You Won!"
            winLabel.isHidden = false
            startGameButton.isHidden = false
            if self.buttonsClicked > 0{
                simonSaysGame = SimonSays()
            }
        }
    }
    
    @IBAction func greenButton(_ sender: Any) {
        buttonsClicked += 1
        let guess = simonSaysGame.guessGreen()
        let win = simonSaysGame.wonGame()
        
        if !guess{
            winLabel.text = "Nope, Try Again."
            winLabel.isHidden = false
            startGameButton.isHidden = false
            if self.buttonsClicked > 0{
                simonSaysGame = SimonSays()
            }
        }
        if win{
            winLabel.text = "You Won!"
            winLabel.isHidden = false
            startGameButton.isHidden = false
            if self.buttonsClicked > 0{
                simonSaysGame = SimonSays()
            }
        }
    }
    
    @IBAction func yellowButton(_ sender: Any) {
        buttonsClicked += 1
        let guess = simonSaysGame.guessYellow()
        let win = simonSaysGame.wonGame()
        
        if !guess{
            winLabel.text = "Nope, Try Again."
            winLabel.isHidden = false
            startGameButton.isHidden = false
            if self.buttonsClicked > 0{
                simonSaysGame = SimonSays()
            }
        }
        if win{
            winLabel.text = "You Won!"
            winLabel.isHidden = false
            startGameButton.isHidden = false
            if self.buttonsClicked > 0{
                simonSaysGame = SimonSays()
            }
        }
    }
    
    @IBAction func blueButton(_ sender: Any) {
        buttonsClicked += 1
        let guess = simonSaysGame.guessBlue()
        let win = simonSaysGame.wonGame()
        
        if !guess{
            winLabel.text = "Nope, Try Again."
            winLabel.isHidden = false
            startGameButton.isHidden = false
            if self.buttonsClicked > 0{
                simonSaysGame = SimonSays()
            }
        }
        if win{
            winLabel.text = "You Won!"
            winLabel.isHidden = false
            startGameButton.isHidden = false
            if self.buttonsClicked > 0{
                simonSaysGame = SimonSays()
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
            self.winLabel.isHidden = true
            
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
