//
//  AnalogStickDelegate.swift
//  Space Explorer
//
//  Created by Marcos Morais on 29/09/2017.
//  Copyright © 2017 Marcos Morais. All rights reserved.
//

import Foundation

protocol AnalogStickDelegate {
    
    func beganTrackingMovement()
    func movementHandler(data: AnalogJoystickData)
    func stoppedTrackingMovement()
    
}

