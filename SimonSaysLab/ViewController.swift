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
    @IBOutlet weak var yelloButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    var simonSaysGame = SimonSays()
    var userPicks = [Color]()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winLabel.text = ""
        
        blueButton.backgroundColor = UIColor.blue
        redButton.backgroundColor = UIColor.red
        yelloButton.backgroundColor = UIColor.yellow
        greenButton.backgroundColor = UIColor.green
        
        showColorButtons(alphaValue: 0.0)
    }
    
    func showColorButtons(alphaValue: CGFloat) {
        blueButton.alpha = alphaValue
        redButton.alpha = alphaValue
        yelloButton.alpha = alphaValue
        greenButton.alpha = alphaValue
    }
    
    func wait(seconds: Int, showAlpha: CGFloat, restart: Bool) {
        unowned let unownedSelf = self
        let deadlineTime = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            unownedSelf.showColorButtons(alphaValue: showAlpha)
            if restart {
                self.startGameButton.isHidden = false
            }
        })
    }
    
    func gameProgress(_ count: Int) {
        if simonSaysGame.wonGame(){
            winLabel.text = "You got lucky this time..."
            restartGame(didWin: true)
        } else if count == 5 && !simonSaysGame.wonGame() {
            winLabel.text = "Nope, try again nerd."
            restartGame(didWin: false)
        }
    }
    
    func restartGame(didWin: Bool) {
        print("(\(self.simonSaysGame.gameNumber)) User chose pattern: \(self.simonSaysGame.chosenColors)")
        wait(seconds: 1, showAlpha: 0.0, restart: true)
        userPicks.removeAll()
        pressCount = 0
        simonSaysGame.colorToDisplay = 0
        simonSaysGame.chosenColors.removeAll()
        
        if didWin {
            startGameButton.setTitle("Play again?",for: .normal)
            simonSaysGame.gameNumber += 1
            simonSaysGame.gameRepeat = false
            simonSaysGame.patternToMatch.removeAll()
        } else {
            startGameButton.setTitle("Try again?",for: .normal)
            simonSaysGame.gameRepeat = true
            simonSaysGame.tryAgainWithTheSamePattern(simonSaysGame.patternToMatch)
        }
    }
    
    var pressCount = 0
    
    @IBAction func redPressed(_ sender: Any) {
        simonSaysGame.guessRed()
        pressCount += 1
        gameProgress(pressCount)
    }
    @IBAction func greenPressed(_ sender: Any) {
        simonSaysGame.guessGreen()
        pressCount += 1
        gameProgress(pressCount)
    }
    @IBAction func YellowPressed(_ sender: Any) {
        simonSaysGame.guessYellow()
        pressCount += 1
        gameProgress(pressCount)
    }
    @IBAction func bluePressed(_ sender: Any) {
        simonSaysGame.guessBlue()
        userPicks.append(.blue)
        pressCount += 1
        gameProgress(pressCount)
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        if simonSaysGame.gameRepeat == false {
            simonSaysGame.resetColors()
        }
        
        displayTheColors()
        winLabel.text = "Playing..."
        wait(seconds: 8, showAlpha: 1.0, restart: false)
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.4, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("(\(self.simonSaysGame.gameNumber)) Pattern to match:   \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
