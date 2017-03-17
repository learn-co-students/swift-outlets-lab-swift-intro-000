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
    var buttonsClicked = 1
    
    @IBAction func buttonYellow(_ sender: Any) {
        print("guess yellow")
        simonSaysGame.guessYellow()
        buttonsClicked = checkWon(timesTried: buttonsClicked)
    }
    @IBAction func buttonBlue(_ sender: Any) {
        print("guess blue")
        simonSaysGame.guessBlue()
        buttonsClicked = checkWon(timesTried: buttonsClicked)
    }
    @IBAction func buttonRed(_ sender: Any) {
        print("guess red")
        simonSaysGame.guessRed()
        buttonsClicked = checkWon(timesTried: buttonsClicked)
    }
    @IBAction func buttonGreen(_ sender: Any) {
        print("guess green")
        simonSaysGame.guessGreen()
        buttonsClicked = checkWon(timesTried: buttonsClicked)
    }
    
    func checkWon(timesTried: Int) -> Int{
        let numC = simonSaysGame.numberOfColorsToMatch
        let winCheck = simonSaysGame.wonGame()
        
        print(winCheck)
        
        if winCheck {
            winLabel.text = "You Won!"
            winLabel.isHidden = false;
        }else{
            print(timesTried)
            if timesTried == numC{
                winLabel.text = "Wrong!"
                winLabel.isHidden = false;
            }
        }
        
        return timesTried + 1
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
