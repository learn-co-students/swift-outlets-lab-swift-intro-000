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
    
    @IBOutlet weak var redSquare: UIButton!
    @IBOutlet weak var yellowSquare: UIButton!
    @IBOutlet weak var blueSquare: UIButton!
    @IBOutlet weak var greenSquare: UIButton!
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    
    @IBAction func redButton(_ sender: AnyObject) {
        simonSaysGame.guessRed()
        print("Red")
        buttonsClicked += 1
        checkHelper()
    }
    
    
    @IBAction func yellowButton(_ sender: AnyObject) {
        simonSaysGame.guessYellow()
        print("Yellow")
        buttonsClicked += 1
        checkHelper()
    }
    
    
    @IBAction func blueButton(_ sender: AnyObject) {
        simonSaysGame.guessBlue()
        print("Blue")
        buttonsClicked += 1
        checkHelper()
    }
    
    
    @IBAction func greenButton(_ sender: AnyObject) {
        simonSaysGame.guessGreen()
        print("Green")
        buttonsClicked += 1
        checkHelper()
    }
    
    func checkHelper() {
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch{
            
            if simonSaysGame.wonGame() == true {
                winLabel.text = "You won!"
                
            } else {
                winLabel.text = "Nope, try again."
                
        }
            winLabel.isHidden = false
            
            reStart()
        }
    }
    
    func reStart() {
        startGameButton.isHidden = false
        buttonsClicked = 0
        simonSaysGame = SimonSays()
        
    }
    
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
