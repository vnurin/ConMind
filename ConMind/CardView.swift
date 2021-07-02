//
//  CardView.swift
//  ConMind
//
//  Created by Vahagn Nurijanyan on 2021-07-01.
//  Copyright © 2021 X INC. All rights reserved.
//

import UIKit

protocol CardViewDelegate: class {
    func view(_ view: CardView)
}

//if there isn't downloaded image (yet), plays with the label number
class CardView: UIView {
    var card: Card! {
        didSet {
            guard card != nil else {
                //new game initialization
                backgroundColor = .yellow
                cardImageView.image = nil
                cardImageView.isHidden = true
                cardLabel.isHidden = true
                return
            }
            if oldValue == nil {
                cardLabel.text = String(card.id)
            }
            if (oldValue == nil || oldValue.image == nil) && card.image != nil {
                //this could be executed only once
                cardLabel.isHidden = true //for not being visible when the imageView is hidden
                cardImageView.image = card.image
            }
            if card.isFaceUp {
                guard !card.isMatched else {
//                    isHidden = true
                    if cardImageView.image != nil {
                        cardImageView.isHidden = true
                    }
                    else {
                        cardLabel.isHidden = true
                    }
                    backgroundColor = .black
                    return
                }
                if cardImageView.image != nil {
                    cardImageView.isHidden = false
                }
                else {
                    cardLabel.isHidden = false
                }
            }
            else {
                if cardImageView.image != nil {
                    cardImageView.isHidden = true
                }
                else {
                    cardLabel.isHidden = true
                }
            }
        }
    }
    weak var delegate: CardViewDelegate?
    
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.borderWidth = 1.0
        layer.masksToBounds = true
        layer.cornerRadius = 16.0
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    @objc func tap() {
        if card != nil && card.isFaceUp {
            return
        }
        delegate?.view(self)
    }
}

