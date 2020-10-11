//
//  Enums.swift
//  Set-Final
//
//  Created by Dhananjay Pahuja on 10/10/20.
//

import Foundation

enum Shape: String, CaseIterable {
    
    case square = "■"
    case circle = "●"
    case triangle = "▲"
}

enum Color: Int, CaseIterable {
    case magenta
    case gold
    case pink
}

enum Number: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
}

enum Shading: Int, CaseIterable {
    case open
    case shaded     //using alpha
    case solid
}
