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
        winLabel.isHidden = true
        super.viewDidLoad()
    }
    
    @IBAction func redButtonTapped (_ sender: UIButton) {
        print("red button")
            simonSaysGame.guessRed()
            checkForWin()
        }

    
    @IBAction func greenButtonTapped (_ sender: UIButton) {
        print("green button")
            simonSaysGame.guessGreen()
            checkForWin()
        }
    
    
    @IBAction func yellowButtonTapped (_ sender: UIButton) {
            simonSaysGame.guessYellow()
            checkForWin()
        }
    
    
    @IBAction func blueButtonTapped (_ sender: UIButton) {
            simonSaysGame.guessBlue()
            checkForWin()
        }
    
        
}



// MARK: - SimonSays Game Methods
extension ViewController {
    
    func checkForWin(){
        if simonSaysGame.wonGame(){
            winLabel.isHidden = false
            winLabel.text = "Congratulations!"
        } else if
            (!simonSaysGame.wonGame() && simonSaysGame.chosenColors.count == simonSaysGame.patternToMatch.count){
                winLabel.isHidden = false
            winLabel.text = "Sorry Try Again"
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
            }
            )
        }
}



 
