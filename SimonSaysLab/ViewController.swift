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
    
    @IBAction func redClicked(_ sender: AnyObject) {
        
       
        simonSaysGame.guessRed()
        
        buttonsClicked += 1
        checkCompleted()
       
        
    }
    
    @IBAction func greenClicked(_ sender: AnyObject) {
        simonSaysGame.guessGreen()
        
        buttonsClicked += 1
        checkCompleted()
        
    }
    @IBAction func yellowClicked(_ sender: AnyObject) {
        simonSaysGame.guessYellow()
        buttonsClicked += 1
       checkCompleted()
    }

    @IBAction func blueClicked(_ sender: AnyObject) {
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        checkCompleted()
    }

    func checkCompleted(){
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch  {
            
            winLabel.isHidden = false
            if simonSaysGame.wonGame() {
                winLabel.text = "You won!"
                
            }else {
                winLabel.text = "Nope,Try again !"
                
            }
            buttonsClicked = 0
            
            startGameButton.isHidden = false
        
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        winLabel.isHidden = true
        super.viewDidLoad()
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
