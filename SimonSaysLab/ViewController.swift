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
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    var picked : Int = 0
    
    @IBAction func redButtonPressed(_ sender: Any) {
        simonSaysGame.guessRed()
        isWon()
    }
    
    @IBAction func greenButtonPressed(_ sender: Any) {
        simonSaysGame.guessGreen()
        isWon()
    }
    
    @IBAction func yellowButtonPressed(_ sender: Any) {
        simonSaysGame.guessYellow()
        isWon()
    }
    
    @IBAction func blueButtonPressed(_ sender: Any) {
        simonSaysGame.guessBlue()
        isWon()
    }
    
    func isWon(){
        picked = picked + 1
        
        if (picked == simonSaysGame.numberOfColorsToMatch) {
            if (simonSaysGame.wonGame()){
                winLabel.text = "You won!"
                changeVisibilityBtns(true)
                startGameButton.isHidden = false
                simonSaysGame = SimonSays()
            } else {
                winLabel.text = "Nope.Try again"
                changeVisibilityBtns(true)
                startGameButton.isHidden = false
                simonSaysGame = SimonSays()
            }
            winLabel.isHidden = false
            picked = 0
        } else {
            winLabel.isHidden = true
        }
    }
    func changeVisibilityBtns(_ flag:Bool){
        redButton.isHidden = flag
        blueButton.isHidden = flag
        greenButton.isHidden = flag
        yellowButton.isHidden = flag
    }
    
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        winLabel.isHidden = true
        changeVisibilityBtns(true)
        super.viewDidLoad()
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
        }, completion: nil)
        
        displayTheColors()
        changeVisibilityBtns(false)
        winLabel.isHidden = true
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
