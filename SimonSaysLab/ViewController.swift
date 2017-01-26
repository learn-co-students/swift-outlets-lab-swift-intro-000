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
    
    
    @IBAction func buttonRed(_ sender: Any) {
        
        simonSaysGame.guessRed()
        playGame()
    
    }
    
    @IBAction func buttonGreen(_ sender: Any) {
        
        simonSaysGame.guessGreen()
        playGame()
    }
    
    @IBAction func buttonBlue(_ sender: Any) {
        
        simonSaysGame.guessBlue()
        playGame()
    }
    
    @IBAction func buttonYellow(_ sender: Any) {
        
        simonSaysGame.guessYellow()
        playGame()
    }
    
    func playGame () {
        
        buttonsClicked += 1
        print(buttonsClicked)
        print("Sequence Finished ?: \(self.simonSaysGame.sequenceFinished())")
        print("Pattern to match: \(self.simonSaysGame.chosenColors)")

// Tried to use the method sequence finished, but it didn't work
        
        if buttonsClicked >= simonSaysGame.numberOfColorsToMatch  {
            
            
        if simonSaysGame.wonGame() {
        winLabel.isHidden = false
        winLabel.text  = "You Won"
       // startAgain()
        
        } else {
        winLabel.isHidden = false
        winLabel.text = "Nope, Try again"
        
          simonSaysGame.chosenColors.removeAll()
          buttonsClicked = 0
            
          print("Pattern to match: \(self.simonSaysGame.chosenColors)")
        }
          
        }
    }
    
    
func startAgain() {
        
        buttonsClicked = 0
        simonSaysGame.colorToDisplay = 0
        winLabel.isHidden = true
        startGameButton.isHidden = false
        simonSaysGame.chosenColors.removeAll()
    
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




