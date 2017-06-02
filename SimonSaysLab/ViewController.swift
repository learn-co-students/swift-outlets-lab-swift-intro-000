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

    @IBOutlet weak var loseLabel: UILabel!
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    @IBAction func Red(_ sender: Any) {
        simonSaysGame.guessRed()
        buttonsClicked += 1
        if buttonsClicked==5 && simonSaysGame.wonGame()==true
        {
            winLabel.isHidden=false
        }
        else if buttonsClicked==5 && simonSaysGame.wonGame()==false
        {
            loseLabel.isHidden=false
        }
    }
    
    @IBAction func Green(_ sender: Any) {
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        if buttonsClicked==5 && simonSaysGame.wonGame()==true
        {
            winLabel.isHidden=false
        }
        else if buttonsClicked==5 && simonSaysGame.wonGame()==false
        {
            loseLabel.isHidden=false
        }    }
    
    @IBAction func Blue(_ sender: Any) {
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        if buttonsClicked==5 && simonSaysGame.wonGame()==true
        {
            winLabel.isHidden=false
        }
        else if buttonsClicked==5 && simonSaysGame.wonGame()==false
        {
            loseLabel.isHidden=false
        }    }
    

    @IBAction func Yellow(_ sender: Any) {
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        if buttonsClicked==5 && simonSaysGame.wonGame()==true
        {
            winLabel.isHidden=false
        }
        else if buttonsClicked==5 && simonSaysGame.wonGame()==false
        {
            loseLabel.isHidden=false
        }    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden=true
        loseLabel.isHidden=true
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
