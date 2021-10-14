//
//  Physicable.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 08/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit


protocol Physicable {
    
    func setUpPhysicsBody(with size: CGSize) -> SKPhysicsBody
    func didBeginContact( contact: SKPhysicsContact)
    func didEndContact( contact: SKPhysicsContact)
}


extension Physicable {
    
    func setUpPhysicsBody(with size: CGSize) -> SKPhysicsBody {
        
        let physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody.categoryBitMask = PhysicsCategory.player
        physicsBody.collisionBitMask = PhysicsCategory.monster | PhysicsCategory.wall
        physicsBody.contactTestBitMask = PhysicsCategory.monster | PhysicsCategory.wall
        physicsBody.friction = 1
      
        return physicsBody
    }
    
    
    func setUpPhysicsBody(with texture: SKTexture, and size: CGSize) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody.categoryBitMask = PhysicsCategory.player
        physicsBody.collisionBitMask = PhysicsCategory.monster | PhysicsCategory.wall
        physicsBody.contactTestBitMask = PhysicsCategory.monster | PhysicsCategory.wall
        physicsBody.allowsRotation = false
        return physicsBody
        
    }
}
