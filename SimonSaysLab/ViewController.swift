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
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winLabel.isHidden = true
        
        redButton.isHidden = true
        greenButton.isHidden = true
        yellowButton.isHidden = true
        blueButton.isHidden = true
    }
    
    @IBAction func buttonRedClick(_ sender: Any) {
        simonSaysGame.guessRed()
        completeMove()
    }
    @IBAction func buttonGreenClick(_ sender: Any) {
        simonSaysGame.guessGreen()
        completeMove()
    }
    @IBAction func buttonYellowClick(_ sender: Any) {
        simonSaysGame.guessYellow()
        completeMove()
    }
    @IBAction func buttonBlueClick(_ sender: Any) {
        simonSaysGame.guessBlue()
        completeMove()
    }
    
    func completeMove() {
        
        buttonsClicked += 1
        
        if buttonsClicked == 5 {
            winLabel.isHidden = false
            
            if simonSaysGame.wonGame() {
                winLabel.text = "You won!"
            } else {
                winLabel.text = "Nope, try again."
            }
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
        
        redButton.isHidden = false
        greenButton.isHidden = false
        yellowButton.isHidden = false
        blueButton.isHidden = false
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
