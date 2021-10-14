//
//  Placar.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 18/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit

class Placar: SKSpriteNode, NotificationDelegate {
    
    var scoreLabel: SKLabelNode!
    
    init(sceneSize: CGSize) {
        let texture = SKTexture(imageNamed: "Placar")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = CGPoint(x: sceneSize.width/2 , y: sceneSize.height * 0.95 - self.size.height/2)
        GameScore.shared.notificationDelegates.append(self)
        self.generateScoreLabel()
    }
    
    private func generateScoreLabel() {
        let label = SKLabelNode(fontNamed: "Noteworthy-Bold")
        label.fontSize = 48
        label.position = CGPoint(x: label.position.x, y: label.position.y - 20)
        label.text = "\(GameScore.shared.getScore())"
        label.color = .white
        label.zPosition = 10
        self.scoreLabel = label
        self.addChild(label)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func scoreChanged(score: Int) {
        self.scoreLabel.color = .white
        self.scoreLabel.text = "\(score)"
    }
    
    
}
