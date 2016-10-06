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
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        hideButtons()
    }
    
    @IBAction func redButton(_ sender: AnyObject) {
        buttonsClicked += 1
        simonSaysGame.guessRed()
        checkFinished()
    }
    
    @IBAction func greenButton(_ sender: AnyObject) {
        buttonsClicked += 1
        simonSaysGame.guessGreen()
        checkFinished()
    }
    
    @IBAction func yellowButton(_ sender: AnyObject) {
        buttonsClicked += 1
        simonSaysGame.guessYellow()
        checkFinished()
    }
    
    @IBAction func blueButton(_ sender: AnyObject) {
        buttonsClicked += 1
        simonSaysGame.guessBlue()
        checkFinished()
    }
    
    func hideButtons() {
        redButton.isHidden = true
        greenButton.isHidden = true
        yellowButton.isHidden = true
        blueButton.isHidden = true
    }
    
    func showButtons() {
        if(simonSaysGame.sequenceFinished()){
            redButton.isHidden = false
            greenButton.isHidden = false
            yellowButton.isHidden = false
            blueButton.isHidden = false
            timer.invalidate()
        }
       
    }
    
    func checkFinished() {
        print(buttonsClicked)
        print(simonSaysGame.numberOfColorsToMatch)
        if(buttonsClicked == simonSaysGame.numberOfColorsToMatch){
            if(simonSaysGame.wonGame()) {
                winLabel.text = "You Won!"
            }else {
                winLabel.text = "Nope, Try again."
            }
            startGameButton.isHidden = false
        }
    }
    
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        hideButtons()
        simonSaysGame = SimonSays()
        buttonsClicked = 0
        timer = Timer.scheduledTimer(timeInterval: 1 , target:self, selector: #selector(showButtons), userInfo: nil, repeats: true)
        winLabel.text = "Playing.."
        
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            self.startGameButton.setTitle("Play Again",for: UIControlState.normal)
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
