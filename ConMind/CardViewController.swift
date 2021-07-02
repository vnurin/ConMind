//
//  CardViewController.swift
//  ConMind
//
//  Created by Vahagn Nurijanyan on 2021-07-01.
//  Copyright © 2021 X INC. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, CardViewDelegate {

    private var game: CardModel!
    private var numberOfPairs: Int {
        (cardViews.count + 1) / 2
    }
    private(set) var flipCount = 0 {
        didSet {
            flipLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak private var flipLabel: UILabel!
    @IBOutlet private var cardViews: [CardView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardViews.forEach { $0.delegate = self }
        game = CardModel(numberOfPairs: numberOfPairs)
    }
    @IBAction private func newGame(_ sender: UIButton) {
        for cardView in cardViews {
            cardView.card = nil
        }
        game = CardModel(numberOfPairs: numberOfPairs)
        flipCount = 0
    }
    
    @IBAction private func switchPicturesMode(_ sender: Any) {
        CardModel.pictures = !CardModel.pictures
    }
    
    //MARK: - CardViewDelegate
    
    func view(_ view: CardView) {
        flipCount += 1
        if let cardNumber = cardViews.firstIndex(of: view) {
            let previousIndex = game.previousFaceUpIndex
            game.chooseCard(at: cardNumber)
            if previousIndex != nil {
                cardViews[previousIndex!].card = game.cards[previousIndex!]
            }
            cardViews[cardNumber].card = game.cards[cardNumber]
            
        }
    }
}


