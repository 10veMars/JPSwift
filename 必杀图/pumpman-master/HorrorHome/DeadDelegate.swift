//
//  DeadDelegate.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 11/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit



protocol DeadDelegate {
    func playerDead(node: SKNode)
    func playerAnimationEnded(node: SKNode)
}
