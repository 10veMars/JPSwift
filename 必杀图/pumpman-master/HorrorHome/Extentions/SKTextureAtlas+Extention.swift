//
//  SKTextureAtlas+Extention.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 09/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit


extension SKTextureAtlas {
    
    func getTextures() -> [SKTexture] {
        var textures: [SKTexture] = []
        for name in textureNames.sorted() {
            let texture = self.textureNamed(name)
            textures.append(texture)
        }
        return textures
    }
}
