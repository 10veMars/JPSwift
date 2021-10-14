//
//  GameLayer.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 08/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit


class GameLayer: SKNode, NotificationDelegate {

    var player: Player!
    var rat: Rat!
    var center: CGFloat!
    var cheese: Cheese!
    var highScoreLabel: SKLabelNode!

    var countDead = 0
    var scoreToPower = 5
    var powerUsedCount = 1
    
    var canJump: Bool = true
    init(size: CGSize) {
        center = size.width/2
        super.init()
        self.startGame(size: size)
        SoundController.shared.playMusic()
    }
    
    func startGame(size: CGSize){
        self.player = Player(position: CGPoint(x: 400, y: 150))
        self.cheese = Cheese(size: size)
        self.addChild(player)
        self.addChild(cheese)
        self.addChild(Placar(sceneSize: size))
        self.addChild(Plataform(sceneSize: size))
        self.createNewRat(size: size)
        self.setHighScoreLabel(size: size)
        GameScore.shared.notificationDelegates.append(self)
    }
    
    
    func setHighScoreLabel(size: CGSize){
        var scoreL: Int
        if let score = GameScore.shared.getHigher() {
            scoreL = score
        }else {
            scoreL = 0
        }
        let label = SKLabelNode(fontNamed: "Noteworthy-Bold")
        label.text = "Best \(scoreL)"
        self.addChild(label)
        label.position = CGPoint(x: size.width/5, y: size.height * 0.95 - label.fontSize)
        self.highScoreLabel = label
        GameScore.shared.newHighCompletion = {score in
            self.highScoreLabel.text = "Best \(score)"
        }
    }
    
    func animateRat(with size: CGSize){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
            self.rat.animateRat()
            self.rat.moveRat(size: size)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scoreChanged(score: Int) {
        if score == (self.scoreToPower * powerUsedCount){
            powerUsedCount += 1
            let powerUp = PowerUp(position: CGPoint(x: CGFloat.random(min: 1, max: center*2), y: 200))
            powerUp.name = "power"
            self.addChild(powerUp)
        }
    }
    
    func createNewRat(size: CGSize){
        if self.rat != nil {
            rat.removeAllActions()
            rat.removeFromParent()
        }
        self.childNode(withName: "power")?.removeFromParent()
        self.rat = Rat(position: CGPoint(x: size.width*0.1, y: size.height*0.5))
        self.addChild(rat)
        self.animateRat(with: size)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x > center && canJump {
                self.player.jump()
            }
        }
    }
}


