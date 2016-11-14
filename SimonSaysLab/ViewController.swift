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
    
    func winOrLose (){
        buttonsClicked += 1
        if  buttonsClicked == 5 {
            winLabel.isHidden = false
                if simonSaysGame.wonGame(){
                    winLabel.text = "You won!"
                } else {
                    winLabel.text = "Nope, try Again."
                }
        }
    }
    
    
    @IBAction func redPressed(_ sender: Any) {
        simonSaysGame.guessRed()
        winOrLose()
    }
    
    @IBAction func greenPressed(_ sender: Any) {
        simonSaysGame.guessGreen()
        winOrLose()
    }
    
    @IBAction func yellowPressed(_ sender: Any) {
        simonSaysGame.guessYellow()
        winOrLose()
    }
    
    @IBAction func bluePressed(_ sender: Any) {
        simonSaysGame.guessBlue()
        winOrLose()
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
