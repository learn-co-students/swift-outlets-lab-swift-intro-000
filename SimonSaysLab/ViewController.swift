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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    //my additions
    @IBAction func redButton(_ sender: AnyObject) {
            simonSaysGame.guessRed()
            buttonsClicked += 1
            print("Pressed Red")
            if buttonsClicked == simonSaysGame.numberOfColorsToMatch{
                displayResult()
            }
    }
    
    @IBAction func grnButton(_ sender: AnyObject) {
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        print("Pressed Grn")
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch{
            displayResult()
        }

    }
    
    @IBAction func ylwButton(_ sender: AnyObject) {
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        print("Pressed Ylw")
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch{
            displayResult()
        }

    }
    @IBAction func bluButton(_ sender: AnyObject) {
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        print("Pressed Blu")
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch{
            displayResult()
        }

    }
    
    func displayResult(){
        if simonSaysGame.wonGame() {
            winLabel.text = "You Won!"
        } else
        {
            winLabel.text = "Nope, try again."
            
        }

        winLabel.isHidden = false
        
        
        reRun()
        
    }

    func reRun() {
        startGameButton.isHidden = false
        //reset variables
        //simonSaysGame.colorToDisplay = 0  //display new colors
        //simonSaysGame.patternToMatch.removeAll()  //store colors displayed
        buttonsClicked = 0
        simonSaysGame = SimonSays()
        //simonSaysGame.chosenColors.removeAll()
        
    }
    
    
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            self.winLabel.isHidden = true    //added for retries
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
