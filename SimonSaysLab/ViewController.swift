//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.winLabel.isHidden = true
        self.buttonView.isUserInteractionEnabled = false
    }
}

// MARK: - SimonSays Game Methods
extension ViewController
{
    
    @IBAction func startGameTapped(_ sender: UIButton)
    {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations:
            {
                self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors()
    {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations:
        {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
        }, completion: { _ in
            if !self.simonSaysGame.sequenceFinished()
            {
                self.displayTheColors()
            }
            else
            {
                self.view.isUserInteractionEnabled = true
                print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                self.buttonView.isUserInteractionEnabled = true
            }
        })
    }
    
    func checkValues(color: UIColor)
    {
        switch color
        {
            case .red:
                simonSaysGame.guessRed()
            case .green:
                simonSaysGame.guessGreen()
            case .yellow:
                simonSaysGame.guessYellow()
            case .blue:
                simonSaysGame.guessBlue()
            default:
                self.winLabel.text = "Try Again."
                self.winLabel.isHidden = false
                simonSaysGame.tryAgainWithTheSamePattern()
        }
        
        let totalChosenColors:Int = simonSaysGame.chosenColors.count
        let totalColors:Int = simonSaysGame.patternToMatch.count
        
        if totalChosenColors >= totalColors
        {
            let didIWin: Bool = simonSaysGame.wonGame()
            
            if didIWin
            {
                self.winLabel.text = "You Won!"
                self.winLabel.isHidden = false
            }
            else
            {
                self.winLabel.text = "Nope Try Again"
                self.winLabel.isHidden = false
            }
        }
    }
    
    @IBAction func redBtnClicked(_ sender: Any)
    {
        checkValues(color: .red)
    }
    
    @IBAction func greenBtnClicked(_ sender: Any)
    {
        checkValues(color: .green)
    }
    
    @IBAction func yellowBtnClicked(_ sender: Any)
    {
        checkValues(color: .yellow)
    }
    
    @IBAction func blueBtnClicked(_ sender: Any)
    {
        checkValues(color: .blue)
    }
}
