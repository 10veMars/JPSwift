//
//  Player.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 08/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit


class Player: SKSpriteNode, GameObject {
    
    
    var inverted: Bool {
        didSet{
            self.xScale = inverted == true ? self.scale : -self.scale
        }
    }

    var velo: CGFloat = 230
    let scale:CGFloat = 0.1
    
    
    var canChangeScore = true
    private var _actualState: PlayerStateMachine?
    
    var deadDelegate: DeadDelegate?
    
    var actualState: PlayerStateMachine? {
        get {
            return self._actualState
        }
        set(state){
            if _actualState != nil {
                 self.removeAction(forKey: self._actualState!.rawValue)
            }
            self._actualState = state
            self.runStateAnimation()
        }
    }
    
    init(position: CGPoint) {
        let texture = SpritesManager.shared.playerIdle.getTextures().first!
        print(texture.size())
        self.inverted = false
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = position
        print(self.size)
        self.setScale(scale)
        self.actualState = .idle
        self.physicsBody = self.setUpPhysicsBody(with: self.texture!, and: self.size)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handlerTracking(data: AnalogJoystickData){

        func makeWalk(){
            if actualState == .jump {
                self.actualState = .walk_jump
            }else if actualState != .walk_jump && actualState != .walk {
                self.actualState = .walk
            }
        }

        if data.velocity.x > 0 {
            if self.physicsBody!.velocity.dx < velo {
                self.physicsBody!.applyForce(CGVector(dx: velo, dy: 0))
            }
            self.inverted = true
            makeWalk()
        }else if data.velocity.x < 0 {
            if self.physicsBody!.velocity.dx > -velo {
                self.physicsBody?.applyForce(CGVector(dx: -velo, dy: 0))
            }
            self.inverted = false
            makeWalk()
        }
        
    }

    func dead(){
        
        if self.actualState != .dead {
            self.removeMonsterCollistion()
            self.deadDelegate?.playerDead(node: self)
            self.removeAction(forKey: PlayerStateMachine.jump.rawValue)
            self.actualState = .dead
        }
    }
    
    func reinit(with newPosition:CGPoint){
         
        self.position = newPosition
        print(self.size)
        self.actualState = .idle
        self.restoreMonsterCollision()
    }
    
    func removeMonsterCollistion(){
        self.physicsBody?.collisionBitMask = PhysicsCategory.wall
        self.physicsBody?.contactTestBitMask = PhysicsCategory.wall
    }
    
    func restoreMonsterCollision(){
        self.physicsBody?.collisionBitMask = PhysicsCategory.wall | PhysicsCategory.monster
        self.physicsBody?.contactTestBitMask = PhysicsCategory.wall | PhysicsCategory.monster | PhysicsCategory.cheese | PhysicsCategory.powerUp
    }
    
    
    func runStateAnimation() {
        
        if let state = self.actualState {
            if state == .jump || state == .walk_jump {
                SoundController.shared.playJump()
                self.run(state.getAnimation(),with: PlayerStateMachine.jump.rawValue, {
                    self.physicsBody?.velocity = CGVector(dx: self.physicsBody!.velocity.dx, dy: 0)
                    self.actualState = .idle
                })
            }else if state == .dead {
                SoundController.shared.playDead()
                self.run(state.getAnimation(), completion: {
                    self.deadDelegate?.playerAnimationEnded(node: self)
                })
            }else{
                self.run(state.getAnimation(), withKey: state.rawValue)
            }
        }
    }
    func stopHandler(){
        if (actualState == .walk) {
            self.actualState = .idle
            self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
    }
    
    func jump(){
        if self.physicsBody?.velocity.dy == 0{
        //if actualState != .jump && actualState != .walk_jump {
            self.physicsBody?.applyImpulse(CGVector(dx: 0,dy: 50))
            self.actualState = .jump
        }
    }

}

extension Player: Physicable {
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyB.node is Rat || contact.bodyA.node is Rat {
            self.dead()
            GameScore.shared.saveIfHigher()
        }else if (contact.bodyA.node is Cheese ||  contact.bodyB.node is Cheese) {
            if canChangeScore {
                GameScore.shared.incrementScore()
                canChangeScore = false
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: {_ in
                    self.canChangeScore = true
                })
            }
        }else if (contact.bodyA.node is PowerUp ||  contact.bodyB.node is PowerUp) {
            self.removeAction(forKey: "powerUp")
            self.velo = 400
            let wait = SKAction.wait(forDuration: 4)
            self.run(SKAction.sequence([wait,SKAction.run {
                self.velo = 230
                }]), withKey: "powerUp")
        }
    }
    
    
    
    
    func didEndContact(contact: SKPhysicsContact) {
    }
    

}

