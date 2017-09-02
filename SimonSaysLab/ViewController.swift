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
    
    @IBOutlet weak var Red: UIButton!
    @IBOutlet weak var Green: UIButton!
    @IBOutlet weak var Yellow: UIButton!
    @IBOutlet weak var Blue: UIButton!
    
    
    
    
    @IBAction func pressedRed(_ sender: Any) {
        print("pressed red")
        buttonsClicked += 1
        simonSaysGame.guessRed()
        if buttonsClicked == 5{
        checkResult()
        }
        
    }
    @IBAction func pressedGreen(_ sender: Any) {
        print("presssed green")
        buttonsClicked += 1
        simonSaysGame.guessGreen()
        if buttonsClicked == 5{
            checkResult()
        }
        
    }
    @IBAction func pressedYellow(_ sender: Any) {
        print("pressed yellow")
        buttonsClicked += 1
        simonSaysGame.guessYellow()
        if buttonsClicked == 5{
            checkResult()
        }
    }
    
    @IBAction func pressedBlue(_ sender: Any) {
    print("pressed blue")
        buttonsClicked += 1
        simonSaysGame.guessBlue()
        if buttonsClicked == 5{
            checkResult()
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
        checkResult()
        }
    func checkResult() {
        if simonSaysGame.sequenceFinished() {
            if simonSaysGame.wonGame() {
                print("you won!")
                winLabel.text = "You won!"
                startGameButton.isHidden = false
            }else {
                print("you lost!")
                winLabel.text = "You lost!"
                //startGameButton.isHidden = false
            }
            
            
        }
        
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
                        //show buttons
                        self.Red.isHidden = false
                        self.Green.isHidden = false
                        self.Yellow.isHidden = false
                        self.Blue.isHidden = false
                    
                    
                }
        })
        

    }
}
