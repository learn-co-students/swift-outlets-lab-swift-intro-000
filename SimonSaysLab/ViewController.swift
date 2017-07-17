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
   
    @IBAction func redButton(_ sender: UIButton) {
        simonSaysGame.guessRed()
        //print("pressed red button")
        if fiveGuesses()==true {doWinLabel()}
    }
    @IBAction func greenButton(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        //print("pressed green button")
        if fiveGuesses()==true {doWinLabel()}
    }
    @IBAction func yellowButton(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        //print("pressed yellow button")
        if fiveGuesses()==true {doWinLabel()}
    }
    @IBAction func blueButton(_ sender: UIButton) {
        simonSaysGame.guessBlue()
        //print("pressed blue button")
        if fiveGuesses()==true {doWinLabel()}
    }
    
    func fiveGuesses()->Bool {
        buttonsClicked+=1
        //print(buttonsClicked)
        if buttonsClicked==5 {
            return true
        } else {
            return false
        }
    }
    
    func doWinLabel() {
        let won = simonSaysGame.wonGame()
        winLabel.isHidden=false
        //startGameButton.isHidden=false
        //buttonsClicked=0
        if won==true {
            winLabel.text="You won!"
        } else {
            winLabel.text="Sorry Try Again."
        }
    }
    
    override func viewDidLoad() {
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
