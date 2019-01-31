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
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        winLabel.isHidden = true
        super.viewDidLoad()
    }
    
    @IBAction func redButtonPressed(_ sender: UIButton)
    {
        print("number of buttons clicked \(buttonsClicked)")
        simonSaysGame.guessRed()
        buttonsClicked += 1
        
        guard buttonsClicked == simonSaysGame.patternToMatch.count else {return}
        if simonSaysGame.wonGame()
        {
            winLabel.text = "You win!"
            winLabel.isHidden = false
        }
        else
        {
            winLabel.text = "Nope, Try Again!"
            winLabel.isHidden = false
        }
    }
    
    @IBAction func greenButtonPressed(_ sender: UIButton)
    {
        print("number of buttons clicked \(buttonsClicked)")
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        
        if simonSaysGame.wonGame()
        {
            winLabel.text = "You win!"
            winLabel.isHidden = false
        }
        else
        {
            winLabel.text = "Nope, Try Again!"
            winLabel.isHidden = false
        }
    }
    
    @IBAction func yellowButtonPressed(_ sender: UIButton)
    {
        simonSaysGame.guessYellow()
        buttonsClicked += 1

        if simonSaysGame.wonGame()
        {
            winLabel.text = "You win!"
            winLabel.isHidden = false
        }
        else
        {
            winLabel.text = "Nope, Try Again!"
            winLabel.isHidden = false
        }
    }
    
    @IBAction func blueButtonPressed(_ sender: UIButton)
    {
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        
        if simonSaysGame.wonGame()
        {
            winLabel.text = "You win!"
            winLabel.isHidden = false
        }
        else
        {
            winLabel.text = "Nope, Try Again!"
            winLabel.isHidden = false
        }
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton)
    {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        print("Start game pressed, displaying colors")
        displayTheColors()
    }
    
    fileprivate func displayTheColors()
    {
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
