//
//  Card.swift
//  Concentration
//
//  Created by Armando Dorantes Bollain y Goytia on 2018-02-02.
//  Copyright © 2018 Armando Dorantes Bollain y Goytia. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
