//
//  CardModel.swift
//  ConMind
//
//  Created by Vahagn Nurijanyan on 2021-07-01.
//  Copyright © 2021 X INC. All rights reserved.
//

import Foundation

class CardModel {
    static var pictures = true
    var cards = [Card]()
    var previousFaceUpIndex: Int?
    
    init(numberOfPairs: Int) {
        for id in 1...numberOfPairs {
            let card = Card(id: id)
            cards += [card, Card(instance: card)]
        }
        //shuffling
        let limit = UInt32(2*numberOfPairs)
        for _ in 0..<numberOfPairs {
            let index1 = Int(arc4random_uniform(limit))
            let index2 = Int(arc4random_uniform(limit))
            if index1 != index2 {
                let buffer = cards[index1]
                cards[index1] = cards[index2]
                cards[index2] = buffer
            }
        }
    }
    
    func chooseCard(at index: Int) {
        let card = cards[index]
        guard !card.isFaceUp else {
            return
        }
        if let matchIndex = previousFaceUpIndex {
            //check if cards match
            //cards[matchIndex] === card
            if cards[matchIndex] == card {
                cards[matchIndex].isMatched = true
                card.isMatched = true//cards[matchIndex] && cards[index] are the same objects...
                previousFaceUpIndex = nil
            }
            else {
                cards[matchIndex].isFaceUp = false
                previousFaceUpIndex = index
            }
        }
        else {
            //no cards face up
            previousFaceUpIndex = index
        }
        card.isFaceUp = true
    }
}
