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
    @IBOutlet weak var statusLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    var gameStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.isHidden = true
    }
    
    @IBAction func redButtonTapped(_ sender : UIButton){
        if gameStarted == true {
            buttonEffect(sender: sender)
            simonSaysGame.guessRed()
            checkGuess()
        } else {
            startGameAlert()
        }
    }

    @IBAction func greenButtonTapped(_ sender : UIButton){
        if gameStarted == true {
            buttonEffect(sender: sender)
            simonSaysGame.guessGreen()
            checkGuess()
        } else {
            startGameAlert()
        }
    }
    
    @IBAction func yellowButtonTapped(_ sender : UIButton){
        if gameStarted == true {
            buttonEffect(sender: sender)
            simonSaysGame.guessYellow()
            checkGuess()
        } else {
            startGameAlert()
        }
    }
    
    @IBAction func blueButtonTapped(_ sender: UIButton) {
        if gameStarted == true {
            buttonEffect(sender: sender)
            simonSaysGame.guessBlue()
            checkGuess()
        } else {
            startGameAlert()
        }
    }
    
    func checkGuess() {
        buttonsClicked = buttonsClicked + 1
        if buttonsClicked == 5 {
            
            var alert : UIAlertController
            
            if simonSaysGame.wonGame() == true {
                alert = UIAlertController(title: "Congratulations you Won! Would you like to play again?", message: nil, preferredStyle: .alert)
            } else {
                alert = UIAlertController(title: "Oh no! You Lost 😢, would you like to try again?", message: "Unfortunaly you did not win, but that does not mean you should give up!", preferredStyle: .alert)
            }
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                self.startGameTapped( self.startGameButton )
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {action in
                self.startGameButton.isHidden = false
                self.statusLabel.isHidden = true
                self.gameStarted = false
            }))
            
            self.present(alert, animated: true)
        }
        return
    }
    
    func buttonEffect(sender: UIButton){
        UIButton.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        }, completion: { finish in
            UIButton.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform.identity
            })
        })
    }
    
    func startGameAlert(){
        let alert = UIAlertController(title: "Would you like to start the game?", message: "Currently there is no game running at this time.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            self.startGameTapped( self.startGameButton )
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
  
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        // Resets
        self.gameStarted = true
        self.buttonsClicked = 0
        self.statusLabel.text = "Playing..."
        
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            self.statusLabel.isHidden = false
            }, completion: nil)

        self.simonSaysGame.getPattern()
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
                    self.statusLabel.text = "Your Turn..."
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
