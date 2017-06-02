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
    var guess = 0
    func check(val : Int) {
        if guess == 5{
            if simonSaysGame.wonGame() {
                winLabel.isHidden = false
                winLabel.text = "You won!"
                
            }
            else {
                winLabel.isHidden = false
                winLabel.text = "Nope, try again."
            }
        }
        
    }
    @IBAction func red1(_ sender: Any) {
        simonSaysGame.guessRed()
        guess+=1
        check(val:guess)
    }

    @IBAction func green1(_ sender: Any) {
                simonSaysGame.guessGreen()
                guess+=1
                check(val:guess)
    }

    @IBAction func yellow1(_ sender: Any) {
                simonSaysGame.guessYellow()
                guess+=1
                check(val:guess)
    }

    @IBAction func blue1(_ sender: Any) {
                simonSaysGame.guessBlue()
                guess+=1
                check(val:guess)
    }

    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
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
