//
//  GameScene.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 06/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit
import GameplayKit
import UnityAds

class GameScene: SKScene {
    
    var gameLayer: GameLayer!
    var hudLayer: HudLayer!
    var backgroundLayer: BackgroundLayer!
    var userDead : Bool = false
    
 

    override init(size: CGSize) {
        super.init(size: size)
        self.setUpLayers(size: size)
        self.configurePhysicsWorld()
      
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        self.physicsBody = self.setUpPhysicsBody(with: view.bounds.size)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

    func configurePhysicsWorld(){
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -10)
    }
    
    func setUpLayers(size: CGSize){
        self.gameLayer = GameLayer(size: size)
        self.hudLayer = HudLayer(size: size)
        self.backgroundLayer = BackgroundLayer(size: size)
        self.addLayers()
    }
    
    func addLayers(){
        self.addChild(self.gameLayer)
        self.addChild(self.hudLayer)
        self.addChild(self.backgroundLayer)
     
        self.gameLayer.player.deadDelegate = self
        self.hudLayer.joystick.trackingHandler = self.gameLayer.player.handlerTracking
        self.hudLayer.joystick.stopHandler = self.gameLayer.player.stopHandler
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !userDead {
            self.gameLayer.touchesBegan(touches, with: event)
            self.hudLayer.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !userDead {
            self.hudLayer.touchesMoved(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !userDead {
            self.hudLayer.touchesEnded(touches, with: event)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !userDead {
            self.hudLayer.touchesCancelled(touches, with: event)
        }
    }
}



extension GameScene: DeadDelegate {
    
    func playerDead(node: SKNode) {
        self.gameLayer.powerUsedCount = 1
        userDead = true
        self.hudLayer.joystick.resetStick()
        self.hudLayer.joystick.disabled = true
    }
    
    func playerAnimationEnded(node: SKNode) {
        if gameLayer.countDead == 6 && UnityAds.isReady("video"){
            self.isPaused = true
            AdsManager.shared.showAdsWithCompletion(id: "video", completion: {
                self.isPaused = false
                self.reinitiate()
            })
            gameLayer.countDead = 0
            return
        }
        if node is Player {
            self.gameLayer.countDead += 1
            self.reinitiate()
        }
    }
    
    func reinitiate(){
        self.gameLayer.player.reinit(with: CGPoint(x: 400, y: 200))
        self.gameLayer.createNewRat(size: self.size)
        self.userDead = false
        self.hudLayer.joystick.disabled = false
        GameScore.shared.saveIfHigher()
        self.gameLayer.cheese.reinit()
    }
    

}

