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
    
    @IBAction func redPress(_ sender: Any) {
        print("Red")
        simonSaysGame.guessRed()
        buttonsClicked += 1
        checkOver(num: buttonsClicked)
    }
    @IBAction func greenPress(_ sender: Any) {
        print("Green")
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        checkOver(num: buttonsClicked)
    }
    @IBAction func yellowPress(_ sender: Any) {
        print("Yellow")
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        checkOver(num: buttonsClicked)
    }
    @IBAction func bluePress(_ sender: Any) {
        print("Blue")
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        checkOver(num: buttonsClicked)
    }
    
    func checkOver(num:Int){
        if (num == 5){
            if(simonSaysGame.wonGame()){
                winLabel.text = "You Won!"
                winLabel.isHidden = false
            }else{
                winLabel.text = "You lose!"
                winLabel.isHidden = false
            }
        }
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
