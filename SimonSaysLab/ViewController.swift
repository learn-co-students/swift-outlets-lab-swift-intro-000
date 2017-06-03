import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!

    @IBAction func redButton(_ sender: Any) { guessColor("Red") }
    @IBAction func greenButton(_ sender: Any) { guessColor("Green") }
    @IBAction func yellowButton(_ sender: Any) { guessColor("Yellow") }
    @IBAction func blueButton(_ sender: Any) { guessColor("Blue") }

    var simonSaysGame = SimonSays()
    var buttonsClicked = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }

    func guessColor(_ color: String) {
        switch color {
        case "Red":
            simonSaysGame.guessRed()
        case "Green":
            simonSaysGame.guessGreen()
        case "Yellow":
            simonSaysGame.guessYellow()
        case "Blue":
            simonSaysGame.guessBlue()
        default:
            checkForEnd()
        }
        checkForEnd()
    }

    func checkForEnd() {
        if simonSaysGame.wonGame() {
            winLabel.text = "You won!"
        } else if simonSaysGame.gameOver() {
            winLabel.text = "You lost :("
        } else {
            winLabel.isHidden = false
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
