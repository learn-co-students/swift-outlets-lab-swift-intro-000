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
    
// color buttons
    @IBAction func btRed(_ sender: Any) {
        simonSaysGame.guessRed()
        buttonsClicked = buttonsClicked + 1
        if simonSaysGame.numberOfColorsToMatch == buttonsClicked{
            checkIfWon()
        }
    }
    
    @IBAction func btGreen(_ sender: Any) {
        simonSaysGame.guessGreen()
        buttonsClicked = buttonsClicked + 1
        if simonSaysGame.numberOfColorsToMatch == buttonsClicked{
            checkIfWon()
        }
    }
    
    @IBAction func btYellow(_ sender: Any) {
        simonSaysGame.guessYellow()
        buttonsClicked = buttonsClicked + 1
        if simonSaysGame.numberOfColorsToMatch == buttonsClicked{
            checkIfWon()
        }
    }
    
    @IBAction func btBlue(_ sender: Any) {
        simonSaysGame.guessBlue()
        buttonsClicked = buttonsClicked + 1
        if simonSaysGame.numberOfColorsToMatch == buttonsClicked{
            checkIfWon()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.winLabel.isHidden = true
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

    func checkIfWon(){
        if self.simonSaysGame.wonGame() {
            self.winLabel.text = "Du vann"
            self.winLabel.isHidden = false
            
        } else {
            self.winLabel.text = "Du förlorade ... "
            self.winLabel.isHidden = false
        }
    }

}
