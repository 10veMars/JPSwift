//
//  SKNode+RunExtention.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 10/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit



extension SKNode {
    
    func run(_ action: SKAction, with key: String,_ completion: @escaping () -> Void){
        let sequence = SKAction.sequence([SKAction.wait(forDuration: action.duration), SKAction.run {
            completion()
            }])
        let group = SKAction.group([action, sequence])
        self.run(group, withKey: key)        
    }
}
