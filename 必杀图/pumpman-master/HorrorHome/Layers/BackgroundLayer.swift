//
//  BackgroundLayer.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 08/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit

class BackgroundLayer: SKNode {

    init(size: CGSize) {
        super.init()
        let node = SKSpriteNode(texture: SKTexture(image:#imageLiteral(resourceName: "background-4")) , size: size)
        self.addChild(node)
        node.anchorPoint = CGPoint.zero
        self.zPosition = -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
