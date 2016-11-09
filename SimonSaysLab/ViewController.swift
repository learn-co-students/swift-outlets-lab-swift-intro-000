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
    
    @IBAction func redButton(_ sender: UIButton) {
        //check if startButton is clicked
        if (buttonsClicked == 1 ){
            simonSaysGame.guessRed()
            checkForWin()
        }
    }
    
    @IBAction func greenButton(_ sender: UIButton) {
        if(buttonsClicked == 1){
        simonSaysGame.guessGreen()
        checkForWin()
        }
    }
    
    
    @IBAction func yellowButton(_ sender: UIButton) {
        if (buttonsClicked == 1){
            simonSaysGame.guessYellow()
            checkForWin()

            }
    }
    
    @IBAction func blueButton(_ sender: UIButton) {
        if (buttonsClicked == 1){
            simonSaysGame.guessBlue()
            checkForWin()
            }
        }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    func checkForWin(){
        if simonSaysGame.wonGame(){
            winLabel.text = "Success!"
            
        }else if( !simonSaysGame.wonGame() && simonSaysGame.chosenColors.count == simonSaysGame.patternToMatch.count){
            winLabel.text = "Nope, try Again!"
        }

        
    }
    
    @IBAction func startGameTapped(_ sender: UIButton) {

        buttonsClicked = 1
        
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
