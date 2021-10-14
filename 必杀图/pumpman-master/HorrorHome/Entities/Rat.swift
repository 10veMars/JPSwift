//
//  Rat.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 09/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit
import GameplayKit


class RatActions {
    
    var rightAndReturn: SKAction!
    var leftAndReturn: SKAction!
    var right: SKAction!
    var left: SKAction!
    
    static private var created = false
    init(size: CGSize,rat:Rat) {
        self.generateActions(size: size, rat: rat)
    }
    
    private func generateActions(size: CGSize, rat: Rat){
        let velocity:TimeInterval = TimeInterval(0.002985 * size.width)
        
        let invertedTrue = SKAction.run {
            rat.inverted = true
        }
        let invertedFalse = SKAction.run {
            rat.inverted = false
        }

        self.left = SKAction.sequence([SKAction.moveTo(x: size.width * 0.08, duration: velocity),invertedTrue])
         let halfLeft = SKAction.sequence([SKAction.moveTo(x: size.width * 0.08, duration: velocity/2),invertedTrue])
        self.right = SKAction.sequence([SKAction.moveTo(x:size.width * 0.92, duration: velocity),invertedFalse])
        let halfRight = SKAction.sequence([SKAction.moveTo(x:size.width * 0.92, duration: velocity/2),invertedFalse])
        let center = SKAction.moveTo(x: size.width/2, duration: velocity/2)
        self.rightAndReturn = SKAction.sequence([center,invertedFalse,halfLeft, invertedTrue,right])
        self.leftAndReturn = SKAction.sequence([center,invertedTrue,halfRight, invertedFalse,left])
    }
    
}

class Rat: SKSpriteNode, GameObject {
  
    var inverted: Bool {
        didSet{
            self.xScale = self.inverted == true ? -self.scale : self.scale
        }
    }
    var ratActions: RatActions!
    let scale: CGFloat = 3.5
    var canChangeScore = true
    init(position: CGPoint) {
        let texture = SpritesManager.shared.ratWalk.getTextures().first!
        texture.filteringMode = .nearest
        self.inverted = true
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = position
        self.setScale(scale)
        self.physicsBody = self.setUpPhysicsBody(with: self.size)
        self.inverted = true
        self.xScale = -self.scale
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    func animateRat(){
        let textures = SpritesManager.shared.ratWalk.getTextures()
        let action = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.1))
        self.run(action)
    }
    func moveRat(size: CGSize){
        if ratActions == nil {
            self.ratActions = RatActions(size: size, rat: self)
        }
        var left: SKAction!
        var right: SKAction!
        
        if CGFloat.random() < 0.3 {
            left = self.ratActions.leftAndReturn
            right = self.ratActions.right
        }else if CGFloat.random() < 0.3 {
            right = self.ratActions.rightAndReturn
            left = self.ratActions.left
        }else {
            left = self.ratActions.left
            right = self.ratActions.right
        }

        let moveAction = SKAction.sequence([right, left])
        self.run(moveAction, completion: {
            self.moveRat(size: size)
        })
    }

    
    func removePlayerCollistion(){
        self.physicsBody?.collisionBitMask = PhysicsCategory.wall
        self.physicsBody?.contactTestBitMask = PhysicsCategory.wall
    }
    
}

extension Rat: Physicable {
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA.node is Player && contact.bodyB.node is Rat) || (contact.bodyB.node is Player && contact.bodyA.node is Rat) {
            self.removePlayerCollistion()
        }else if (contact.bodyA.node is Cheese ||  contact.bodyB.node is Cheese) {
            if canChangeScore {
                GameScore.shared.decrementScore()
                canChangeScore = false
                DispatchQueue.main.async {
                    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: {_ in
                        self.canChangeScore = true
                    })
                }
            }
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
    
    func setUpPhysicsBody(with size: CGSize) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(texture: self.texture!, size: size)
        physicsBody.categoryBitMask = PhysicsCategory.monster
        physicsBody.collisionBitMask = PhysicsCategory.player | PhysicsCategory.wall
        physicsBody.contactTestBitMask = PhysicsCategory.player | PhysicsCategory.wall | PhysicsCategory.cheese
        physicsBody.allowsRotation = false
        return physicsBody
    }
    
}
