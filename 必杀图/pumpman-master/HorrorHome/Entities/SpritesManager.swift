//
//  SpritesManager.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 09/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit


class SpritesManager {
    
     var playerIdle: SKTextureAtlas!
     var playerWalk: SKTextureAtlas!
     var playerRun: SKTextureAtlas!
     var playerDead: SKTextureAtlas!
     var playerJump: SKTextureAtlas!
     var ratWalk: SKTextureAtlas!

    static let shared: SpritesManager = SpritesManager()
    func carregarSprites(){
        DispatchQueue.main.async {
            self.playerIdle = SKTextureAtlas(named: "character_idle")
            self.playerWalk = SKTextureAtlas(named: "character_walk")
            self.playerRun = SKTextureAtlas(named: "character_run")
            self.playerDead = SKTextureAtlas(named: "character_dead")
            self.playerJump  = SKTextureAtlas(named: "character_jump")
            self.ratWalk = SKTextureAtlas(named: "rat_walk")
        }
  
    }
    
    private init() {}
    
}



