//
//  Plataform.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 18/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit

class Plataform: SKSpriteNode, Physicable {
    
    
    init(sceneSize: CGSize) {
        let texture = SKTexture(imageNamed: "grass")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.anchorPoint = CGPoint.zero
        self.position = CGPoint(x: 0, y: 0)
        self.physicsBody = self.setUpPhysicsBody(with: CGSize(width: self.size.width,height: self.size.height - 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
    
    func setUpPhysicsBody(with size: CGSize) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint.zero, size: size))
        physicsBody.categoryBitMask = PhysicsCategory.wall
        physicsBody.collisionBitMask = PhysicsCategory.player | PhysicsCategory.monster | PhysicsCategory.cheese
        physicsBody.contactTestBitMask = PhysicsCategory.player | PhysicsCategory.monster
        return physicsBody
    }
}
