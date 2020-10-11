//
//  CardsModel.swift
//  Set-Final
//
//  Created by Dhananjay Pahuja on 10/10/20.
//

import Foundation

class CardsModel {
    
    var deck = [Card]()
    var renderedCardsOnScreen = [Card]()
    
    private func loadDeck() {
        for i in Number.allCases {
            for char in Shape.allCases {
                for shade in Shading.allCases {
                    for color in Color.allCases {
                        deck.append(
                            Card(color: color,
                                 shape: char,
                                 number: i,
                                 shading: shade)
                        )
                    }
                }
            }
        }
    }
    
    private func render1card() -> Card {
        let randCard = deck.remove(at: Int(arc4random_uniform(UInt32(deck.count))))
        return randCard
    }
    
    func remove1card(selectedCards: [Card]) {
        
        for j in 0..<selectedCards.count {
            for i in 0..<renderedCardsOnScreen.count {
                if renderedCardsOnScreen[i] == selectedCards[j] {
                    renderedCardsOnScreen.remove(at: i)
                    break
                }
            }
        }
    }
    
    private func loadOnScreenCards() {
        for _ in 0..<12 {
            renderedCardsOnScreen.append(render1card())
        }
    }
    
    init() {
        loadDeck()
        loadOnScreenCards()
    }
    
    func deal3MoreCards() {
        for _ in 0..<3 {
            if renderedCardsOnScreen.count < 24 || deck.count > 0 {
                renderedCardsOnScreen.append(render1card())
            }
            else {
                return
            }
        }
    }
    
    
    func getOnScreenCards() -> [Card] {
        return renderedCardsOnScreen
    }
    
    func getDeck() -> [Card] {
        return deck
    }
    
    
    func isMatched(selectedCards: [Card]){
        if deck.count < 3 {
            remove1card(selectedCards: selectedCards)
            return
        }
    
        for i in 0..<renderedCardsOnScreen.count {
            for j in 0..<selectedCards.count {
                if renderedCardsOnScreen[i] == selectedCards[j] {
                    renderedCardsOnScreen.remove(at: i)
                    renderedCardsOnScreen.insert(render1card(), at: i)          //point F
                }
            }
        }
    }
}
