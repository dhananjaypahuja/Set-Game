//
//  Game.swift
//  Set-Final
//
//  Created by Dhananjay Pahuja on 10/10/20.
//

import Foundation

class Game {
    
    private var scoreCount: Int
    private var cardsModel: CardsModel
    private var currentCards: [Card]
    private var currentSet: [Card] = []
    
    init() {
        scoreCount = 0
        cardsModel = CardsModel()
        currentCards = cardsModel.getOnScreenCards()
    }
    
    func selectCard(index: Int) {
        
        for i in 0..<currentSet.count {
            if currentSet[i] == currentCards[index] {
                currentSet.remove(at: i)
                scoreCount -= 1
                return
            }
        }
        
        if currentSet.count > 3 {
            return
        }
        
        currentSet.append(currentCards[index])
    }
    
    func deal3Cards() {
        cardsModel.deal3MoreCards()
        currentCards = cardsModel.getOnScreenCards()
    }
    
    func countOnScreenCard() -> Int {
        return currentCards.count
    }
    
    func returnScore() -> Int {
        return scoreCount
    }
    
    func returnCard_i(index: Int) -> Card? {
        if index < currentCards.count && index >= 0 {
            return currentCards[index]
        }
        else {
            return nil
        }
    }
    
    private func shapeEquatable(card1: Card, card2: Card, card3: Card) -> Bool {
        var retVal: Bool = false
        if(card1.shape == card2.shape &&
            card1.shape == card3.shape) {
            retVal = true
        } else if(card1.shape != card2.shape &&
                    card1.shape != card3.shape &&
                    card2.shape != card3.shape) {
            retVal = true
        } else {
            retVal = false
        }
        return retVal
    }
    
    private func colorEquatable(card1: Card, card2: Card, card3: Card)-> Bool {
        var boolean: Bool = false
        if(card1.color == card2.color &&
            card1.color == card3.color) {
            boolean = true
        } else if(card1.color != card2.color &&
                    card1.color != card3.color &&
                    card2.color != card3.color) {
            boolean = true
        } else {
            boolean = false
        }
        return boolean
    }
    
    private func shadeEquatable(card1: Card, card2: Card, card3: Card) -> Bool {
        var retVal: Bool = false
        if(card1.shading == card2.shading &&
            card1.shading == card3.shading) {
            retVal = true
        } else if(card1.shading != card2.shading &&
                    card1.shading != card3.shading &&
                    card2.shading != card3.shading) {
            retVal = true
        } else {
            retVal = false
        }
        return retVal
    }
    
    private func numbEquatable(card1: Card, card2: Card, card3: Card) -> Bool {
        var retVal: Bool = false
        if(card1.number == card2.number &&
            card1.number == card3.number) {
            retVal = true
        } else if(card1.number != card2.number &&
                    card1.number != card3.number &&
                    card2.number != card3.number) {
            retVal = true
        } else {
            retVal = false
        }
        return retVal
    }
    
    func checkEquatable() -> Bool {
        
        var boolean: Bool = false
        if currentSet.count == 0 {
            return boolean
        }
        
        if colorEquatable(card1: currentSet[0], card2: currentSet[1], card3: currentSet[2]) {
            if shadeEquatable(card1: currentSet[0], card2: currentSet[1], card3: currentSet[2]) {
                if numbEquatable(card1: currentSet[0], card2: currentSet[1], card3: currentSet[2]) {
                    if shapeEquatable(card1: currentSet[0], card2: currentSet[1], card3: currentSet[2]) {
                        boolean = true
                        cardsModel.isMatched(selectedCards: currentSet)
                        currentCards = cardsModel.getOnScreenCards()
                    }
                }
            }
        }
        
        if boolean {
            scoreCount += 3
        }
        else {
            scoreCount -= 4
        }
        currentSet.removeAll()
        return boolean
    }
}
