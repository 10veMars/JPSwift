//
//  PoweUP.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 24/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit


class PowerUp:SKSpriteNode, Physicable {
    
    init(position: CGPoint){
        let texture = SKTexture(image: #imageLiteral(resourceName: "orb"))
        super.init(texture: texture, color: .clear, size: texture.size())
        self.setScale(0.2)
        self.position = position
        self.zPosition = 1
        self.physicsBody = self.setUpPhysicsBody(with: self.size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setUpPhysicsBody(with size: CGSize) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody.categoryBitMask = PhysicsCategory.powerUp
        physicsBody.collisionBitMask = PhysicsCategory.wall
        physicsBody.contactTestBitMask = PhysicsCategory.player
        physicsBody.affectedByGravity = true
        return physicsBody
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.node is Player || contact.bodyB.node is Player {
            SoundController.shared.playPowerUp()
            self.removeFromParent()
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
    
    
}
