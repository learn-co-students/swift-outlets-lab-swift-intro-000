//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // this to initiate the guess
    
    
    
    // all the buttons in the game
    @IBAction func buttonRed(_ sender: AnyObject) {
        simonSaysGame.guessRed()
        buttonsClicked += 1
        print(buttonsClicked)
        checkIfRight()
    }
    
    @IBAction func buttonGreen(_ sender: AnyObject) {
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        print(buttonsClicked)
        checkIfRight()
    }
    @IBAction func buttonYellow(_ sender: AnyObject) {
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        print(buttonsClicked)
        checkIfRight()
    }
    @IBAction func buttonBlue(_ sender: AnyObject) {
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        print(buttonsClicked)
        checkIfRight()
    }
    
    
    
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    
    // This to start the game, button start
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
        
        }
    
    func checkIfRight(){
        if buttonsClicked == 5 {
            win()
        }else {
            print("Not yet")
        }
    }
    
    func win(){
        if simonSaysGame.chosenColors == simonSaysGame.patternToMatch {
            winLabel.isHidden = false
            winLabel.text = "Ya bruv!"
            print("Win")
        }else {
            winLabel.isHidden = false
            winLabel.text = "LOL noob"
        }
    }
    
    
    func result(){
    if buttonsClicked >= 5 {
    winLabel.isHidden = false
    winLabel.text = "Ya bruv!"
        print("Check")
    }else{
    winLabel.isHidden = false
    winLabel.text = "LOL noob"
        }
    }
    
    // This is to call the colour sequence
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
