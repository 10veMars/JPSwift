//
//  GameScene+Physicable.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 09/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit


extension GameScene: Physicable {
    func didBeginContact(contact: SKPhysicsContact) {
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
    
    func setUpPhysicsBody(with size: CGSize) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint.zero, size: size))
        physicsBody.categoryBitMask = PhysicsCategory.wall
        physicsBody.collisionBitMask = PhysicsCategory.player | PhysicsCategory.monster | PhysicsCategory.cheese
        physicsBody.contactTestBitMask = PhysicsCategory.player | PhysicsCategory.monster
        physicsBody.restitution = 0.7
        return physicsBody
    }
}


extension GameScene: SKPhysicsContactDelegate {
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        switch contact.bodyA.node {
        case is Player:
            (contact.bodyA.node as! Player).didBeginContact(contact: contact)
        case is Rat:
            (contact.bodyA.node as! Rat).didBeginContact(contact: contact)
        case is GameScene:
            (contact.bodyA.node as! GameScene).didBeginContact(contact: contact)
        case is Cheese:
            (contact.bodyA.node as! Cheese).didBeginContact(contact: contact)
        case is PowerUp:
            (contact.bodyA.node as! PowerUp).didBeginContact(contact: contact)
        default:
            print("nothing")
        }
        
        switch contact.bodyB.node {
        case is Player:
            (contact.bodyB.node as! Player).didBeginContact(contact: contact)
        case is Rat:
            (contact.bodyB.node as! Rat).didBeginContact(contact: contact)
        case is GameScene:
            (contact.bodyB.node as! GameScene).didBeginContact(contact: contact)
        case is Cheese:
            (contact.bodyB.node as! Cheese).didBeginContact(contact: contact)
        case is PowerUp:
            (contact.bodyB.node as! PowerUp).didBeginContact(contact: contact)
        default:
            print("Nothing")
        }
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }

}
