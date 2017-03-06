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
    
//    @IBOutlet weak var red: UIButton!
//    @IBOutlet weak var green: UIButton!
//    @IBOutlet weak var yellow: UIButton!
//    @IBOutlet weak var blue: UIButton!
  
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    var gameWon: Bool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }
    
// This function is called q/time color() funcs are called:
    func decis() {
        buttonsClicked += 1
       
        gameWon = simonSaysGame.wonGame()
        
        if buttonsClicked == 5 && gameWon == true {
                winLabel.text = "You Won!"
                winLabel.isHidden = false
            } else if buttonsClicked == 5 && gameWon == false {
                winLabel.text = "Nope, try again."
                winLabel.isHidden = false
            }
        }
        
    
    
    
    @IBAction func red(_ sender: Any) {
        simonSaysGame.guessRed()
        decis()
    }
    
    @IBAction func green(_ sender: Any) {
        simonSaysGame.guessGreen()
        decis()
    }
    
    @IBAction func yellow(_ sender: Any) {
        simonSaysGame.guessYellow()
        decis()
    }
    
    @IBAction func blue(_ sender: Any) {
        simonSaysGame.guessBlue()
        decis()
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
