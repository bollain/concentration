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
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int ){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) Provided index is not in cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //Check if we have a match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                //Either no cards or 2 cards are up
                //Set all cards face down (overkill)
                //Set selected index as face up
                indexOfOneAndOnlyFaceUpCard = index
                
            }
        }
    }
    
    init(numberOfPairs: Int){
        assert(numberOfPairs > 0, "Concentration.numberOfPairs(\(numberOfPairs)) Number of pairs must be at least one")
        for _ in 1...numberOfPairs{
            let card = Card()
            cards += [card, card]
        }
        
        //TODO: Shuffle the cards
        
    }
}
