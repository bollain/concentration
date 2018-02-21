//
//  Concentration.swift
//  Concentration
//
//  Created by Armando Dorantes Bollain y Goytia on 2018-02-02.
//  Copyright © 2018 Armando Dorantes Bollain y Goytia. All rights reserved.
//

import Foundation

class Concentration
{
    private let matchPoint = 2
    private let penalty = 1
    private(set) var cards = [Card]()
    private(set) var flipCounts = 0
    private(set) var score = 0
    private(set) static var highScore = 0
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            let faceupCardIndices = cards.indices.filter { cards[$0].isFaceUp }
            return faceupCardIndices.count == 1 ? faceupCardIndices.first : nil
        }
        
        set {
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue)}
        }
    }
    
    func chooseCard(at index: Int ){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) Provided index is not in cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //Check if we have a match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += matchPoint
                } else {
                    if cards[index].isSeen {
                        score -= penalty
                    }
                    if cards[matchIndex].isSeen {
                        score -= penalty
                    }
                    cards[index].isSeen = true
                    cards[matchIndex].isSeen = true
                }
                cards[index].isFaceUp = true
            } else {
                //Either no cards or 2 cards are up
                //Set all cards face down (overkill)
                //Set selected index as face up
                indexOfOneAndOnlyFaceUpCard = index
                
            }
        }
        flipCounts += 1
        if score > Concentration.highScore {
            Concentration.highScore = score
        }
    }
    
    init(numberOfPairs: Int){
        assert(numberOfPairs > 0, "Concentration.numberOfPairs(\(numberOfPairs)) Number of pairs must be at least one")
        var unshuffledCards = [Card]()
        for _ in 1...numberOfPairs{
            let card = Card()
            unshuffledCards += [card, card]
        }
        
        while !unshuffledCards.isEmpty {
            let randomIndex = unshuffledCards.count.arc4random
            let card = unshuffledCards.remove(at: randomIndex)
            cards.append(card)
        }
        
    }
}
