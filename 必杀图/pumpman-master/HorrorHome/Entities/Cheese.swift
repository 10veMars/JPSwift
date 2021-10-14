//
//  Cheese.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 18/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit

let cheeseTexture = SKTexture(image: UIImage(named: "cheese")!)
class Cheese: SKSpriteNode, Physicable {
    
    let sceneSize: CGSize
 
    var contactHappen: Bool = false
    let scale:CGFloat = 0.7
    init(size: CGSize) {
        self.sceneSize = size
        super.init(texture: cheeseTexture, color: .clear, size: cheeseTexture.size())
        self.setScale(0.7)
        self.physicsBody = self.setUpPhysicsBody(with: self.size)
        self.position = self.generatePosition()
    }
    
    func generatePosition() -> CGPoint{
        let x = CGFloat.random(min: 0, max: self.sceneSize.width)
        let y = self.sceneSize.height * 0.7
        return CGPoint(x: x, y: y)
    }
    
    
    func reinit(){
        self.position = self.generatePosition()
    
    }
    
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        if !contactHappen{
            self.contactHappen = true
            self.run(SKAction.sequence([SKAction.scale(to: 1.4, duration: 0.05),SKAction.scale(to: scale, duration: 0.05)]))
            SoundController.shared.playCheese()
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {_ in
                    DispatchQueue.main.async {
                        self.reinit()
                    }
                    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: {_ in
                        self.contactHappen = false
                })
            })
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
      
    }
    
    func setUpPhysicsBody(with size: CGSize) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody.categoryBitMask = PhysicsCategory.cheese
        physicsBody.collisionBitMask = PhysicsCategory.wall
        physicsBody.contactTestBitMask = PhysicsCategory.monster | PhysicsCategory.player
        physicsBody.allowsRotation = false
        return physicsBody
    }
    
}
