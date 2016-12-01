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
    
    @IBOutlet weak var red:UIButton!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var yellow: UIButton!
    @IBOutlet weak var blue: UIButton!
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    @IBAction func red(_ sender: UIButton) {
        simonSaysGame.guessRed()
        print(simonSaysGame.guessRed(), "red")
        
        buttonsClicked += 1
        checked()
        
    }
    @IBAction func green(_ sender: UIButton) {
        simonSaysGame.guessGreen()
        print(simonSaysGame.guessGreen(), "green")
        
         buttonsClicked += 1
        checked()
    }
    @IBAction func yellow(_ sender: UIButton) {
        simonSaysGame.guessYellow()
        print(simonSaysGame.guessYellow(), "yellow")
        
         buttonsClicked += 1
        checked()
    }
    @IBAction func blue(_ sender: Any) {
        simonSaysGame.guessBlue()
        print(simonSaysGame.guessBlue(), "blue")
        
         buttonsClicked += 1
        checked()
    }
    
    func checked() {
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
            winLabel.isHidden = false
            if simonSaysGame.wonGame(){
                winLabel.text = "You Won!"}
            else{
                winLabel.text = "You lost"
            }
        }
        
    }
    
    override func viewDidLoad() {
        winLabel.isHidden = true
        super.viewDidLoad()
    }

}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.4, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 0.1, options: .transitionCurlUp, animations: {
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
