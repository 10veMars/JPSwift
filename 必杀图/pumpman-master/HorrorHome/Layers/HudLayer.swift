//
//  HudLayer.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 08/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit

class HudLayer: SKNode {
    
    var analogDelegate: AnalogStickDelegate?
    var joystick = 🕹(diameter: 100, colors: (UIColor.white, UIColor.lightGray))
    
    var center: CGFloat
    
    init(size: CGSize) {
        center = size.width/2
        super.init()
        self.zPosition = 10
        self.configureJoystick(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var jumping = false
    
    func configureJoystick(size: CGSize){
        self.joystick.alpha = 0.25
        self.joystick.substrate.color = .white
        self.joystick.stick.color = .lightGray
        self.addChild(self.joystick)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x < center {
                if !self.joystick.tracking {
                    self.joystick.position = location
                    self.joystick.touchesBegan(touches, with: event)
                }
            }else {
                jumping = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x < center {
                joystick.touchesMoved(touches, with: event)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if location.x < center || !jumping {
                self.joystick.touchesEnded(touches, with: event)
            }else {
                jumping = false
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x < center {
                self.joystick.touchesCancelled(touches, with: event)
            }
        }
        
    }
    
}
