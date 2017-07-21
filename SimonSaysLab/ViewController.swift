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
    var buttonsLog = 0
    
    @IBAction func redButton(_ sender: Any) {
        simonSaysGame.guessRed()
        whoIsWinner()
        
    }
    @IBAction func greenButton(_ sender: Any) {
        simonSaysGame.guessGreen()
        whoIsWinner()
    }
    @IBAction func yellowButton(_ sender: Any) {
        simonSaysGame.guessYellow()
        whoIsWinner()
    }
    @IBAction func blueButton(_ sender: Any) {
        simonSaysGame.guessBlue()
        whoIsWinner()
    }
 
   /* @IBAction func playAgain(_ sender: Any) {
        viewDidLoad()
        winLabel.isHidden = false
    }*/
    func whoIsWinner() {
        buttonsLog += 1
        print(buttonsLog)
        if buttonsLog >= 5 && simonSaysGame.wonGame() {
            print("end of game")
            print(simonSaysGame.wonGame())
            winLabel.text = "Winner Winner Chicken Dinner"
            winLabel.isHidden = false
        } else if buttonsLog >= 5 {
            winLabel.text = "Better Luck Next Time"
            winLabel.isHidden = false
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
