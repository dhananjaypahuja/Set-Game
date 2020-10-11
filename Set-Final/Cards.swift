//
//  Cards.swift
//  Set-Final
//
//  Created by Dhananjay Pahuja on 10/10/20.
//

import Foundation

struct Card: Equatable {
    
    let color: Color
    let shape: Shape
    let number: Number
    let shading: Shading
    
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return(lhs.number == rhs.number && lhs.shape == rhs.shape && lhs.color == rhs.color && lhs.shading == rhs.shading)
    }
}
