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
    let red = "red"
    let green = "green"
    let yellow = "yellow"
    let blue = "blue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }
    
    @IBAction func pressedRed(_ sender: UIButton) {
        colorGussed( red )
    }
    
    @IBAction func pressedGreen(_ sender: UIButton) {
        colorGussed( green )
    }
    
    @IBAction func pressedYellow(_ sender: UIButton) {
        colorGussed( yellow )
    }
    
    @IBAction func pressedBlue(_ sender: UIButton) {
        colorGussed( blue )
    }
    
    func colorGussed(_ color: String ) {
        switch color {
        case red:
            simonSaysGame.guessRed()
        case green:
            simonSaysGame.guessGreen()
        case yellow:
            simonSaysGame.guessYellow()
        default:
            simonSaysGame.guessBlue()
        }
        checkProgress()
    }
    
    func checkProgress() {
        buttonsClicked += 1
        isEndGame()
    }
    
    func isEndGame() {
        if( buttonsClicked == 5 )
        {
            switch simonSaysGame.wonGame() {
            case true:
                winLabel.text = "You won!"
            default:
                winLabel.text = "Nope, try again."
            }
            winLabel.isHidden = false
        }
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
        startGameButton.isHidden = true
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 0.5, options: .transitionCurlUp, animations: {
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
