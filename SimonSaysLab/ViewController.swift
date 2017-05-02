//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

enum buttonTapped {
  case red
  case green
  case yellow
  case blue
}

class ViewController: UIViewController {
  
  @IBOutlet weak var displayColorView: UIView!
  @IBOutlet weak var startGameButton: UIButton!
  @IBOutlet weak var winLabel: UILabel!
  
  
  var simonSaysGame = SimonSays()
  var buttonsClicked = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    winLabel.isHidden = true
  }
  
  
  //MARK: - Handling pressed buttons
  
  // lot of debugging statements in that can be removed to make the code shorter.
  
  func updateAndCheckGameProgress(tapped: buttonTapped) {
    buttonsClicked += 1 // Update number of times a button has been tapped.
    
    switch tapped {
    case .red:
        simonSaysGame.guessRed()
    case .green:
      simonSaysGame.guessGreen()
    case .yellow:
      simonSaysGame.guessYellow()
    case .blue:
      simonSaysGame.guessBlue()
    }
    
    // Check game progress.
    if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
      if simonSaysGame.wonGame() {
        // print("Game won")
        winLabel.text = "Game won"
        winLabel.isHidden = false
      } else {
        // print("Game lost")
        winLabel.text = "Game lost"
        winLabel.isHidden = false
      }
    } else {
      print("Select next color")
    }
  }
 
  @IBAction func redButtonTapped() {
    updateAndCheckGameProgress(tapped: .red)
  }
  
  @IBAction func blueButtonTapped() {
    updateAndCheckGameProgress(tapped: .blue)
  }
  
  @IBAction func yellowButtonTapped() {
    updateAndCheckGameProgress(tapped: .yellow)
  }
  
  @IBAction func greenButtonTapped() {
    updateAndCheckGameProgress(tapped: .green)
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
