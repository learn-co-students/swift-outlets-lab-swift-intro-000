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

    @IBAction func greenBtn(_ sender: Any) {
        simonSaysGame.guessGreen()
        print("greenBtn")
        compareColors()
    }
    @IBAction func redBtn(_ sender: Any) {
        simonSaysGame.guessRed()
        print("redBtn")
        compareColors()
    }
    @IBAction func blueBtn(_ sender: Any) {
        simonSaysGame.guessBlue()
        print("blueBtn")
        compareColors()
    }

    @IBAction func yellowBtn(_ sender: Any) {
        print("yellowBtn")
        simonSaysGame.guessYellow()
        compareColors()
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
            }, completion: nil)
        winLabel.isHidden = false
        displayTheColors()
//        showAll()
        self.startGameButton.isHidden = true
    }

    func compareColors(){
        buttonsClicked += 1

        if(simonSaysGame.numberOfColorsToMatch == buttonsClicked){ //compare te timpes the buttn is clicked vs the number of colors
            if(simonSaysGame.wonGame()){
                winLabel.isHidden = false //show label
                winLabel.text = "🎊🎉 You Won 🎉🎊"
                startGameButton.isHidden = false
            }
//            }else{
//                winLabel.isHidden = false //show label
//                winLabel.text = "You lose"
//            }
//            startGameButton.isHidden = false
//            winLabel.isHidden = true
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
                }
        })
    }
}
