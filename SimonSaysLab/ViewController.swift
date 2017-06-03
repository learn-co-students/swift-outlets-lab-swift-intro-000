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
    var simonSaysGame = SimonSays()
    var buttonsClicked = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func redClick(_ sender: Any) {
        simonSaysGame.guessRed()
        
        cond()
    }
    
    @IBAction func greenClick(_ sender: Any) {
        simonSaysGame.guessGreen()
        
        cond()
    }
    
    @IBAction func yellowClick(_ sender: Any) {
        simonSaysGame.guessYellow()
        
        cond()
    }
    
    @IBAction func blueClick(_ sender: Any) {
        simonSaysGame.guessBlue()
        
        cond()
    }
    
    func win() -> Bool {
        print(buttonsClicked)
        if simonSaysGame.wonGame() {
            winLabel.text = "you win!"
            return true
            
        }
        return false
    }
    
    func tryagain() {
        let sizeOfPattern = simonSaysGame.patternToMatch.count
        
        if (buttonsClicked >= sizeOfPattern) {
            
            winLabel.text = "Try again!"
            simonSaysGame.tryAgainWithTheSamePattern()
            buttonsClicked = 0
        }
        
    }
    
    func cond() {
        if(!win()) {
            tryagain()
        }
        buttonsClicked += 1
        
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
