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
    
    @IBAction func tappedRed(_ sender: UIButton) {
        simonSaysGame.guessRed()
        determineResultAfter(clicksCount: buttonsClicked)
    }
    
    func determineResultAfter(clicksCount: Int) {
        if clicksCount == 4 {
            winLabel.isHidden = false
            if simonSaysGame.wonGame() == true {
                winLabel.text = "You have Won!"
            } else {
            winLabel.text = "Nope try again"
            buttonsClicked = 0
            }
        }else {
            buttonsClicked += 1
        }
    }
    
    @IBAction func tappedYellow(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        determineResultAfter(clicksCount: buttonsClicked)
    }
    @IBAction func tappedGreen(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        determineResultAfter(clicksCount: buttonsClicked)
    }
    
    
    @IBAction func tappedBlue(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        determineResultAfter(clicksCount: buttonsClicked)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        winLabel.isHidden = true
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
                    self.winLabel.isHidden = true
                }
        })
    }
}
