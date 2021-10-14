//
//  PlayerStateMachine.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 10/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit


enum PlayerStateMachine: String {
    
    case `idle`
    case `walk`
    case `dead`
    case `jump`
    case `walk_jump`
    
    func getAnimation() -> SKAction {
        switch self {
        case .idle:
            let action = SKAction.animate(with: SpritesManager.shared.playerIdle.getTextures(), timePerFrame: 0.1, resize: true, restore: true)
            return SKAction.repeatForever(action)
        case .walk:
            let action = SKAction.animate(with: SpritesManager.shared.playerRun.getTextures(), timePerFrame: 0.08)
            return SKAction.repeatForever(action)
        case .dead:
           

            let action = SKAction.animate(with: SpritesManager.shared.playerDead.getTextures(), timePerFrame: 0.1, resize: true, restore: true)
            return action
        
        case .jump, .walk_jump:
            let action = SKAction.animate(with: SpritesManager.shared.playerJump.getTextures(), timePerFrame: 0.084)
            return action
            
        }
    }
    

    
    
}
