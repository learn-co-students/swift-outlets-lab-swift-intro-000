//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

/*
 TODO:
    - gameWon() isnt triggering, so either the color isnt being registered/received or the colors arent connect to send
    - Find out which ibaction func to dump these under, either the viewdidLoad or the gamestarttapped.
 */

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    
    @IBAction func redButton(_ sender: UIButton) {
        simonSaysGame.guessRed()
        buttonsClicked += 1
        print("\(buttonsClicked) || Touched Red")
    }
    
    @IBAction func greenButton(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        print("\(buttonsClicked) || Touched Green")
    }
    
    @IBAction func yellowButton(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        print("\(buttonsClicked) || Touched Yellow")
    }
    
    @IBAction func blueButton(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        print("\(buttonsClicked) || Touched Blue")
    }
    
    func hideInitially() {
        winLabel.isHidden = true
        displayColorView.isHidden = true
    }
    
    func revealNow() {
        winLabel.isHidden = false
        displayColorView.isHidden = false
    }

    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideInitially()
    }
    
    }

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        revealNow()
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
        
        
        if simonSaysGame.wonGame() {
            print("Conditions fulfilled, game won")
            winLabel.text = "You Won!"
        }

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
