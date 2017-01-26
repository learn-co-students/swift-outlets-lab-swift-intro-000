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
    @IBAction func pushRed(_ sender: UIButton) {
        simonSaysGame.guessRed()
        checkStatus()
    }
    
    @IBAction func pushGreen(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        checkStatus()
    }
    @IBAction func pushYellow(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        checkStatus()
    }
    @IBAction func pushBlue(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        checkStatus()
    }
    
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        winLabel.isHidden = true
        super.viewDidLoad()
        
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        winLabel.isHidden = false
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
    
    func checkStatus() {
        switch simonSaysGame.sequenceFinished() {
            case true: checkWin()
            default: return
        }
    }
    
    func checkWin() {
        if simonSaysGame.wonGame() == true {
            winLabel.text = "Game won!"
            startGameButton.isHidden = false
        } else {
            winLabel.text = "Nope try again"
        }
    }

}
