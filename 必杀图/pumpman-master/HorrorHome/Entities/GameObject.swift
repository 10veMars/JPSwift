
//
//  GameObject.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 08/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let player: UInt32 = 0b1 << 1
    static let monster: UInt32 = 0b1 << 2
    static let wall: UInt32 = 0b1 << 3
    static let cheese: UInt32 = 0b1 << 4
    static let powerUp: UInt32 = 0b1 << 5
}

protocol GameObject {
    
    var inverted: Bool {get set}
    
}
