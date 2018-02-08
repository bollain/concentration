//
//  ViewController.swift
//  Concentration
//
//  Created by Armando Dorantes Bollain y Goytia on 2018-02-01.
//  Copyright © 2018 Armando Dorantes Bollain y Goytia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var game: Concentration!
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    typealias ThemeData = (emoji: [String], backgroundColor: UIColor, cardColor: UIColor)
    
    var themes: [String: ThemeData] = [
        "halloween": (["🕷", "🍭", "👻", "☠️", "🎃", "🙀", "👹", "😈", "👽", "👺"], #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)),
        "animals": (["🐶", "🐱", "🐭", "🐹", "🐷", "🐸", "🐴", "🐵", "🐼", "🐯"], #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1), #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)),
        "sports": (["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏏", "🏑"], #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
        "flags": (["🇨🇦", "🇲🇽", "🇱🇷", "🇲🇾", "🇮🇹", "🇱🇧","🇺🇸", "🇮🇸", "🇩🇪", "🇮🇩"], #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)),
        "smileys": (["😀", "😂", "🤬", "🤫", "🤯", "😳", "😡", "🤢", "🤮", "🤑"], #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
        "food": (["🥑", "🌮", "🌭", "🥩", "🍕", "🍔", "🍳", "🌯", "🍤", "🍣"], #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
    ]
    
    private var newTheme: ThemeData {
        let randomIndex = themes.count.arc4random
        let key = Array(themes.keys)[randomIndex]
        return themes[key]!
    }
    
    private var theme: ThemeData! {
        didSet {
            view.backgroundColor = theme.backgroundColor
            cardButtons.forEach {
                $0.backgroundColor = theme.cardColor
                $0.setTitle("", for: UIControlState.normal)
            }
            flipsCountLabel.textColor = theme.cardColor
            scoreCountsLabel.textColor = theme.cardColor
            highScoreLabel.textColor = theme.cardColor
        }
    }
    
    private var emojiChoices = [String]()
    private var emoji = [Int:String]()
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipsCountLabel: UILabel!
    
    @IBOutlet private weak var scoreCountsLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            flipsCountLabel.text = "Flips: \(game.flipCounts)"
            scoreCountsLabel.text = "Score: \(game.score)"
        } else {
            print("Card was not in array!")
        }
        
    }
    
    @IBOutlet weak var newGameButton: UIButton! {
        didSet {
            newGameButton.titleLabel?.numberOfLines = 0
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        startNewGame()
    }
    
    func startNewGame(){
        game = Concentration(numberOfPairs: numberOfPairsOfCards)
        theme = newTheme
        emojiChoices = theme.emoji
        emoji = [Int:String]()
        flipsCountLabel.text = "Flips: \(game.flipCounts)"
        scoreCountsLabel.text = "Score: \(game.score)"
        highScoreLabel.text = "High score: \(Concentration.highScore)"
        
    }
    
    override func viewDidLoad() {
        startNewGame()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : theme.cardColor
            }
        }
        
    }
    
 
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?"
        
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

