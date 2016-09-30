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
    @IBOutlet weak var redBox: UIView!
    @IBOutlet weak var greenBox: UIView!
    @IBOutlet weak var yellowBox: UIView!
    @IBOutlet weak var blueBox: UIView!
    
    @IBAction func redButton(_ sender: UIButton) {
        
    }
    
    @IBAction func greenButton(_ sender: UIButton) {
    }
    
    @IBAction func yellowButton(_ sender: UIButton) {
    }
    
    @IBAction func blueButton(_ sender: UIButton) {
    }
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideInitially()
    }
    
    func hideInitially() {
        winLabel.isHidden = true
        redBox.isHidden = true
        greenBox.isHidden = true
        yellowBox.isHidden = true
        blueBox.isHidden = true
        displayColorView.isHidden = true
    }
    
    func revealNow() {
        winLabel.isHidden = false
        redBox.isHidden = false
        greenBox.isHidden = false
        yellowBox.isHidden = false
        blueBox.isHidden = false
        displayColorView.isHidden = false
    }
}

/*
 TODO:
    - everytime the color changes, simon says will also display the actual color it's being changed to
 */

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        revealNow()
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
