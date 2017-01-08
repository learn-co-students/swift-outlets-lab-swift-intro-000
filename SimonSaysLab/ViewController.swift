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
    
    @IBOutlet weak var barbarians: UIButton!
    @IBOutlet weak var france: UIButton!
    @IBOutlet weak var egypt: UIButton!
    @IBOutlet weak var zulus: UIButton!
    
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }
    
    @IBAction func colorButtonTapped (_ sender: UIButton){
        switch sender {
            case barbarians:
                simonSaysGame.guessRed()
            case france:
                simonSaysGame.guessBlue()
            case zulus:
                simonSaysGame.guessGreen()
            case egypt:
                simonSaysGame.guessYellow()
            default:
                break
        }
        
        buttonsClicked+=1
        
        if simonSaysGame.wonGame() {
            showbuttons()
            winLabel.text = "You won!"
            simonSaysGame = SimonSays()
        }
        else if buttonsClicked % 5 == 0 {
            showbuttons()
            winLabel.text = "Nope, try again."
            simonSaysGame.tryAgainWithTheSamePattern()
        }
    }
    
    func showbuttons () {
        winLabel.isHidden = false
        startGameButton.isHidden = false
    }
    
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            self.winLabel.isHidden = true
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
