//
//  Card.swift
//  ConMind
//
//  Created by Vahagn Nurijanyan on 2021-07-01.
//  Copyright © 2021 X INC. All rights reserved.
//

import Foundation
import UIKit

//this can't be struct for not having downloaded image only in the original (for not having it also in the copies made before image was downloaded)

protocol Copyable: class {
    init(instance: Self)
}
class Card: Equatable, Copyable {
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var isFaceUp = false
    //if isMatched == true, the card is out of the game
    var isMatched = false
    var image: UIImage!
    
    init(id: Int) {
        self.id = id
        guard CardModel.pictures else {return}
        if let url = URL(string: "https://loremflickr.com/500/500") {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                if let data = data {
                    if let image = UIImage(data: data) {
                        self?.image = image
                    }
                }
                else {
                    debugPrint(error!.localizedDescription)
                }
            }.resume()
        }
    }
    
    required init(instance: Card) {
        id = instance.id
        guard CardModel.pictures else {return}
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {[weak self] timer in
            if instance.image != nil {
                self?.image = instance.image
                timer.invalidate()
            }
        }
    }

}
