//
//  SimonSaysGame.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

enum Color: Int {
    case red, green, yellow, blue
}

// MARK: - UIColor Display
extension Color {
    var colorToDisplay: UIColor {
        switch self {
        case .red:
            return UIColor.red
        case .green:
            return UIColor.green
        case .yellow:
            return UIColor.yellow
        case .blue:
            return UIColor.blue
        }
    }
}


// MARK: - CustomStringConvertible Protocol
extension Color: CustomStringConvertible {
    var description: String {
        switch self {
        case .red:
            return "Red"
        case .green:
            return "Green"
        case .yellow:
            return "Yellow"
        case .blue:
            return "Blue"
        }
    }
}


struct SimonSays {
    
    var chosenColors = [Color]()
    var patternToMatch = [Color]()
    var colorToDisplay = 0
    var gameRepeat = true
    var gameNumber = 1
    let numberOfColorsToMatch: Int
    
    
    init(numberOfColorsToMatch: Int = 5) {
        self.numberOfColorsToMatch = numberOfColorsToMatch
        
        for _ in (0..<numberOfColorsToMatch) {
            let randomNumber = Int(arc4random_uniform(4))
            let randomColor = Color(rawValue: randomNumber)!
            patternToMatch.append(randomColor)
        }
    }
}


// MARK: - Gameplay methods
extension SimonSays {
    
    mutating func resetColors(numberOfColorsToMatch: Int = 5) {
        for _ in (0..<numberOfColorsToMatch) {
            let randomNumber = Int(arc4random_uniform(4))
            let randomColor = Color(rawValue: randomNumber)!
            patternToMatch.append(randomColor)
        }
    }
    mutating func nextColor() -> Color? {
        var color: Color? = nil
        if colorToDisplay < patternToMatch.count {
            color = patternToMatch[colorToDisplay]
        }
        colorToDisplay += 1
        return color
    }

    func sequenceFinished() -> Bool {
        return colorToDisplay > patternToMatch.count
    }

    func wonGame() -> Bool {
        return chosenColors == patternToMatch
    }
    
    fileprivate mutating func makeGuessWith(_ color: Color) -> Bool {
        guard chosenColors.count < patternToMatch.count else { return false }
        chosenColors.append(color)
        return patternToMatch[chosenColors.count - 1] == color
    }

    mutating func guessRed() {
        makeGuessWith(.red)
    }
    
    mutating func guessGreen() {
        makeGuessWith(.green)
    }
    
    mutating func guessYellow() {
        makeGuessWith(.yellow)
    }
    
    mutating func guessBlue() {
        makeGuessWith(.blue)
    }
    
    mutating func tryAgainWithTheSamePattern(numberOfColorsToMatch: Int = 5, _ pattern: [Color]) {
        patternToMatch.removeAll()
        for i in (0..<numberOfColorsToMatch) {
            patternToMatch.append(pattern[i])
        }
    }
}
