//
//  ViewController.swift
//  Concentration
//
//  Created by Armando Dorantes Bollain y Goytia on 2018-02-01.
//  Copyright © 2018 Armando Dorantes Bollain y Goytia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairs: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    private var flipCounts = 0 {
        didSet {
            flipsCountLabel.text = "Flips: \(flipCounts)"
        }
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipsCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCounts += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Card was not in array!")
        }
        
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
        
    }
    
    private var emojiChoices = ["🕷", "🍭", "👻", "☠️", "🎃", "🙀", "👹", "😈", "👽"]
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
        
    }
    

}

